# AGENTS.md

Guidance for AI agents working in this repository.

## What this repo is

The SaltStack state tree that builds **SIFT** (SANS Investigative Forensic Toolkit) — a
DFIR workstation image. It is **not** an application: there is no build step, no test
suite in the usual sense, and no code that runs on this machine. Every `.sls` file is a
Salt state that installs or configures forensics tooling on a target Ubuntu host.

Installation is driven by [cast](https://github.com/ekristen/cast), which reads
`.cast.yml`, downloads a single-binary Salt, and applies the state tree:

```console
sudo cast install teamdfir/sift-saltstack
```

Upstream repo: `git@github.com:teamdfir/sift-saltstack.git`. Issues live in the
[SIFT repo](https://github.com/sans-dfir/sift/issues) prefixed `[SALTSTACK]`.

## Supported targets

`.cast.yml` is the source of truth: **Ubuntu 22.04 (jammy)** and **24.04 (noble)**, on
**amd64 and arm64**. Salt **3006** and **3007** are both tested. Focal (20.04) is EOL and
should not be added to new code paths.

## Layout

```
.cast.yml                  cast manifest: modes, supported OS, pillar templates
VERSION                    vestigial (stale — see Known rough edges)
sift/
  desktop.sls  server.sls  the two real entrypoints
  vm.sls       pkgs.sls    legacy aliases -> desktop / server
  include-desktop.sls      desktop = server + config
  include-server.sls       server  = repos + python3-packages + packages + scripts
  repos/                   apt repos and PPAs (gift, sift, docker, microsoft, ubuntu-*)
  packages/                ~240 files, one apt package or .deb per file
  python3-packages/        tools installed into per-tool virtualenvs under /opt
  perl-packages/           CPAN modules via cpanm
  scripts/                 tools installed from tarballs/zips/git, plus wrappers
  config/                  hostname, timezone, folders, samba, user/ (desktop only)
  files/                   static payloads served via salt://sift/files/...
  tests/                   aggregate states used by the weekly CI job only
.ci/                       local dev helpers: test-state.sh, shell.sh
.github/workflows/         the CI that actually runs
```

Salt state IDs mirror paths: `sift/packages/foo.sls` → `sift.packages.foo`, and
`sift/packages/init.sls` → `sift.packages`.

## Entrypoints and the include graph

```
sift.desktop  -> sift.include-desktop -> sift.server -> sift.include-server -> repos
                                      -> sift.config                          python3-packages
                                                                              packages
                                                                              scripts
sift.server   -> sift.include-server
```

`cast` exposes these as modes: `desktop` (default) and `server`; `complete` and
`packages-only` are deprecated aliases.

## Conventions

Match the surrounding files. The tree is old and not uniformly consistent, so "what the
neighbours do" beats "what's globally most common."

### One tool per file

Each `.sls` under `packages/`, `python3-packages/`, `scripts/` installs exactly one tool.
Never bundle two tools into one file — CI tests changed states individually, so bundling
breaks the ability to test one thing.

### Register the new state in `init.sls`

Every directory's `init.sls` has a two-part structure that must be kept in sync:

```yaml
include:
  - sift.packages.newtool          # <- add here

sift-packages:
  test.nop:
    - name: sift-packages
    - require:
      - sls: sift.packages.newtool # <- and here
```

Adding to only one of the two lists is the most common mistake in this repo. A state
that is only in `include:` still runs, but the aggregate `test.nop` no longer gates on
it, so ordering guarantees quietly weaken.

Exception: a package that exists purely as a dependency of another state does not need
an `init.sls` entry — it gets pulled in transitively by whoever `include:`s it. 24 files
under `packages/` are dependency-only this way (`libicu`, `zlib1g-dev`,
`software-properties-common`, `dotnet`, …). Only add to `init.sls` when the tool should be
installed on its own merit.

But a state in neither `init.sls` **nor** any other state's `include:` is dead — it never
runs, and nothing reports that. Fourteen packages sat that way for years, several of them
receiving "updated for 24.04" commits while unreachable. Before adding a dependency-only
state, confirm something actually includes it.

### Header comment block

Tool-facing states carry a metadata header (present on ~66 of 240 package files, and on
most newer additions). Include it on anything user-visible; skip it for pure build deps.

```yaml
# Name: AESKeyFinder
# Website: https://citp.princeton.edu/our-work/memory/
# Description: Find 128-bit and 256-bit AES keys in a memory image.
# Category:
# Author: Nadia Heninger, Alex Halderman
# License: Free, unknown license
# Notes: aeskeyfind
```

`Notes:` is the list of binaries the tool puts on `$PATH` — keep it accurate, it is the
only machine-readable record of what SIFT provides.

### State ID naming

Two conventions coexist in `packages/`: bare `<pkgname>:` (128 files, the older style)
and `sift-package-<pkgname>:` (91 files, the newer style). **Use the `sift-` prefix for
new files.** Do not mass-rename existing IDs — other states reference them by ID in
requisites, and renaming silently breaks those requisites.

Prefixes by directory:

| Directory          | State ID prefix                 |
| ------------------ | ------------------------------- |
| `packages/`        | `sift-package-<name>`           |
| `python3-packages/`| `sift-python3-package-<name>`   |
| `perl-packages/`   | `sift-perl-package-<name>`      |
| `scripts/`         | `sift-scripts-<name>`           |
| `repos/`           | `sift-<name>-repo`              |
| `config/`          | `config-<name>` / `sift-config-`|

### Pair every `include:` with a `require:`

Salt's `include:` makes states available but does **not** order them. Anything you
include as a dependency must also be required:

```yaml
include:
  - sift.repos.gift

sift-package-libewf:
  pkg.installed:
    - name: libewf
    - require:
      - sls: sift.repos.gift
```

Watch the spelling: the requisite is `require`, not `requires`, and `include` is not a
requisite. Salt state functions accept `**kwargs`, so a misspelled requisite is
**silently ignored** rather than raising — the state appears to work and the ordering
guarantee is simply gone.

### Jinja whitespace control will eat your state

A `{%- ... -%}` tag strips whitespace on the trimmed side, newlines included. Putting a
header comment above a leading `{%- set ... %}` therefore splices the last comment line
onto whatever follows, commenting out the first state in the file. Salt reports this as
`ID <module.function> in SLS <name> is not a dictionary`, which points at the state
rather than the comment. Use `{% set` (no leading dash) for the first tag after a comment
block — `sift/packages/claude-code.sls` carries a note where it bit.

Since Jinja renders before YAML parses, `{#` also opens a Jinja comment. That makes
`${#array[@]}` unwritable inside a `contents:` block; restructure the shell instead.

### Pillars

Four pillar keys are read, all with defaults, all via `salt['pillar.get']`:

| Pillar          | Default            | Set by cast |
| --------------- | ------------------ | ----------- |
| `sift_user`     | `sansforensics`    | yes         |
| `sift_version`  | `stable`           | yes         |
| `sift_hostname` | `siftworkstation`  | no          |
| `sift_timezone` | `Etc/UTC`          | no          |

Declare them at the top of the file: `{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}`.
`sift_version` selects the `stable` vs `dev` PPA in `repos/sift.sls` and `repos/gift.sls`.

### Architecture and release guards

arm64 support is partial and guarded explicitly. Two patterns are in use:

```jinja
{%- if grains["osarch"] == "aarch64" or grains["osarch"] == "arm64" -%}
```

for picking a different download URL/hash, and

```yaml
    - onlyif:
      - fun: match.grain
        tgt: 'osarch:amd64'
```

for skipping an amd64-only package entirely. Use `grains['oscodename']` (jammy/noble)
for release-specific branching. Never hardcode a codename or `amd64` in a URL — that was
the subject of several recent fixes.

### Version and hash pinning

Anything downloaded outside apt is pinned with an explicit version and SHA256, set as
Jinja variables at the top of the file, with per-arch hashes where needed:

```jinja
{# renovate: datasource=github-release-attachments depName=radareorg/radare2 #}
{%- set version = "5.9.6" -%}
{%- set base_url = "https://github.com/radareorg/radare2/releases/download/" -%}
{%- if grains["osarch"] == "aarch64" or grains["osarch"] == "arm64" -%}
{%- set hash = "c5b958a6..." -%}
{%- set filename = "radare2_" ~ version ~ "_arm64.deb" -%}
{%- else -%}
{%- set hash = "596c2b2e..." -%}
{%- set filename = "radare2_" ~ version ~ "_amd64.deb" -%}
{%- endif -%}
```

Downloads land in `/var/cache/sift/archives/` (preferred) via `file.managed` with
`source_hash: sha256={{ hash }}`, then `pkg.installed: - sources:` or
`archive.extracted` consumes them. Some older states use `/tmp` and clean up after
themselves; prefer `/var/cache/sift/archives/`.

`skip_verify: True` appears in four places and should be treated as a defect, not a
pattern to copy — this is a forensics distribution and unverified downloads undermine it.

The renovate config in `.github/renovate.json` auto-bumps pins when the file carries a
`{# renovate: datasource=... depName=... #}` comment followed by a `set version = "..."`
line. A `set hash = "..."` line after it is picked up as the digest if present, and
skipped if not — so version-only pins whose `source_hash` is a remote `.sha256` URL work
too. Matching is done against whole-file content with the dotAll flag, so the comment and
the `set` lines need not be adjacent.

Two cases where you should **not** add an annotation, because renovate would make things
worse rather than better:

- **Two arch-specific hashes in one file** (`radare2.sls`, `aws-cli.sls`,
  `claude-code.sls`). The manager captures a single digest, so a bump refreshes one arch's
  hash and leaves the other stale — an install that fails its `source_hash` check on that
  arch. `radare2.sls` is annotated and has this limitation today.
- **Downloads hosted off GitHub** (`aws-cli.sls` → `awscli.amazonaws.com`,
  `claude-code.sls` → a Google Storage bucket). Renovate can find the version but cannot
  compute the new digest, so it would bump the version against a stale hash.

Also do not annotate `repos/sift.sls` or `repos/gift.sls`: their `version` variable holds
a PPA channel name (`stable`/`dev`) from a pillar, not a version number.

If you change the regex, validate it the way renovate applies it — compiled with the `s`
flag against whole-file content. A greedy `(?<currentValue>.*)` silently swallows
following lines and yields a `currentValue` that is not a version, which renovate then
drops on the floor; that bug sat in this config for years and only looked like it worked
because the one annotated file happened to have a single `hash =` literal.

### Python tools go in their own virtualenv

Never `pip install` into the system Python. The pattern is a virtualenv under `/opt/<tool>`,
a `pip.installed` against its interpreter, and symlinks into `/usr/local/bin`:

```yaml
sift-python3-package-volatility3-venv:
  virtualenv.managed:
    - name: /opt/volatility3
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-volatility3:
  pip.installed:
    - name: volatility3
    - bin_env: /opt/volatility3/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-volatility3-venv

sift-python3-package-volatility3-symlink-vol:
  file.symlink:
    - name: /usr/local/bin/vol
    - target: /opt/volatility3/bin/vol
    - force: True
    - makedirs: False
    - require:
      - pip: sift-python3-package-volatility3
```

Pin git installs to a commit SHA (`git+https://…@<sha>`), not a branch.

### Repos use DEB822

New apt sources are written as DEB822 `.sources` files with an explicit `Signed-By`
keyring path, and the corresponding legacy `.list` file is removed with `file.absent`.
See `repos/microsoft.sls` for the full shape. PPAs still use `pkgrepo.managed` with
`ppa:` and a `keyid`.

### Static files

Payloads live under `sift/files/<tool>/` and are referenced as
`salt://sift/files/<tool>/<name>`. Use `file.managed` for one file, `file.recurse` for a
tree.

### Render-time network calls are a deliberate exception, not a pattern

`scripts/exiftool.sls` calls `salt['http.query']` during Jinja rendering to discover the
latest version and its checksum. That was an intentional choice (PR #195,
`exiftool_dynamic_update`) because exiftool releases far more often than this repo does —
don't "fix" it. But don't copy it either: it makes the state non-reproducible, breaks
offline and air-gapped installs, and means a highstate can install a different version
than it did yesterday. For anything else, pin explicitly.

## Testing

There is nothing to run on this machine — states need a real Ubuntu target. Everything
happens in the same container image CI uses.

`.github/workflows/tests.yml` computes the set of changed `.sls` files on every push/PR
(skipping `init.sls`), turns each into a state name, and runs it standalone across the
matrix of Salt 3006/3007 × Ubuntu 22.04/24.04:

```console
salt-call --local -l info --file-root . --retcode-passthrough \
  --state-output=mixed state.sls sift.packages.newtool pillar="{sift_user: root}"
```

To reproduce locally, from the repo root (requires a working container runtime):

```console
.ci/test-state.sh sift.packages.newtool           # defaults to 22.04 / salt 3007
OS=24.04 SALT=3006 .ci/test-state.sh sift.packages.newtool
```

`.ci/shell.sh` drops you into the same image with the tree at `/srv/salt`, for poking at a
state by hand. Both accept `DOCKER=nerdctl` (or podman) if that's your runtime, and pass
`--file-root .` exactly as CI does — that flag is what makes `sift.packages.newtool`
resolve to `./sift/packages/newtool.sls`, so run them from the repo root.

Both work against a remote docker context. `.ci/lib.sh` checks the context endpoint and
streams the tree in over stdin when the daemon is remote, because a bind mount would
otherwise resolve on the remote host and hand salt an **empty state tree** — which is not
an error, so it looks like a state that does nothing. Keep that in mind if you write your
own container invocation.

Available image tags are `22.04-3006`, `22.04-3007`, `24.04-3006`, `24.04-3007`. The
codename forms (`jammy-3007`, `noble-3007`) are aliases for the same images.

Rendering the whole graph without installing anything is a fast way to catch broken
requisites and Jinja errors:

```console
salt-call --local --file-root . state.show_sls sift.desktop pillar='{sift_user: root}'
```

Pass the pillar — several states under `config/user/` call `salt['user.info'](user).home`,
which fails to render when `sift_user` defaults to a `sansforensics` account that does not
exist in a fresh container.

**Mind the CI gap.** Because the workflow tests only *changed*, non-`init` states in
isolation, three classes of change go completely untested:

- editing an `init.sls` — explicitly filtered out, so **registering a new state does not
  get that state tested**. If you wire up a state without touching the state file itself,
  run it locally.
- a change that breaks some *other* state's dependency ordering.
- anything under `sift/files/`, which never matches the `.sls` filter.

Check those by hand, especially when touching shared states like `repos/*` or
`packages/python3*`.

`.github/workflows/weekly-tests.yml` runs a fixed set of aggregate states
(`sift.packages.python3`, `sift.tests.gift`, `sift.tests.libewf`,
`sift.config.user.pdfs`) on a Monday cron.

## Adding a tool — checklist

1. Pick the right directory: apt package or `.deb` → `packages/`; Python tool → `python3-packages/`;
   tarball/zip/git/wrapper script → `scripts/`; CPAN module → `perl-packages/`.
2. Create `<toolname>.sls` with the header comment block, filling in `Notes:` with the
   binaries it exposes.
3. Add every dependency to `include:` **and** to `require:`.
4. Pin version + SHA256 for non-apt downloads; add the renovate annotation in the exact
   documented shape.
5. Guard arch-specific and release-specific behaviour on grains.
6. Register in the directory's `init.sls` — both the `include:` list and the `test.nop`
   `require:` list — unless it is a dependency-only state.
7. Run the state in the tester container on 22.04 and 24.04 before opening a PR.

## Release

Releases are cut by cast, driven by `.cast.yml`, and tagged `vYYYY.MM.DD` (with
`-rcN` for prereleases). Signing keys live in `pgp.pub` and `cosign.pub`.

`VERSION` is vestigial. Its only consumer was a Travis-era release script that no longer
exists, and nothing in the tree or in the cast binary reads it. It is currently synced to
the latest tag by hand; either wire it into the release process or delete it.

## Known rough edges

Things that look like bugs but are deliberate, plus real limitations that are not worth
fixing blind. Listed so you don't "fix" them as a side effect of unrelated work.

**Deliberate, leave alone:**

- `sift/packages/claude-code.sls` ships by default and cannot be managed by renovate — it
  is hosted off GitHub with one hash per arch, so the custom manager can only carry a
  single digest. Bump it by hand; the file records how. It was opt-in between `34b42da`
  and the commit that re-enabled it, so older discussion may say otherwise.
- `sift/python3-packages/mulder.sls` ships by default. It needs an LLM API key to do
  anything and sends evidence content to a third-party provider, which is why it was
  opt-in until the commit that registered it — older discussion says it is not in
  `init.sls`, and describes a `sift/scripts/mulder.sls` that fetched a 3.6 GB container
  image. Both predate the move to the PyPI package.
  Its `mulder setup` step fetches ~2.2 GB of assets into `/opt/mulder-assets` as
  `sift_user`, so it dominates image build time. That step is skipped under the
  `sift_user: root` pillar CI uses, because upstream refuses to provision assets as root
  — the state says so via `test.show_notification` rather than skipping quietly, and
  fails hard when `sift_user` names an account that does not exist. **The asset step is
  never verified by CI**; apply it by hand on a real target. Everything else — venv,
  pinned install, wrappers — does run in CI, and `SKIP_STATES` in
  `.github/workflows/tests.yml` is empty as a result.
  The `/usr/local/bin` entry points are wrappers, not symlinks, because
  `MULDER_ASSET_ROOT` has to be exported at run time as well as at setup time.
  `sift/packages/yara.sls` was added for it and is registered in `packages/init.sls` —
  SIFT shipped the `python3-yara` module but never the scanner. `binutils.sls`,
  `libpango.sls` and `libharfbuzz.sls` stay dependency-only and arrive transitively; the
  last two are WeasyPrint's run-time stack for the `pdf` extra, which pip installs
  happily without and then fails at import.
- `sift/python3-packages/trudi.sls` ships by default as well, and was opt-in for the same
  reason — full use needs an `ANTHROPIC_API_KEY` and sends evidence content to the
  provider. It runs in CI. `sift/packages/binwalk.sls` exists only as its dependency and
  is deliberately not in `packages/init.sls`; it is no longer dead, since registering
  trudi pulls it in transitively.
  Do not switch it to upstream's `install.sh`: that script builds its venv at the generic
  `~/.venv`, overwrites `~/.claude/CLAUDE.md`, runs `claude mcp add --scope user`, copies
  case studies into `~/cases`, and runs an 1100-test suite — all wrong for an image build.
  It is also pinned to a commit on `main` rather than its `1.0.0` tag on purpose: the tag
  predates the fixes that make it work on SIFT at all.
- `sift/tests/*.sls` are intentionally outside the main include graph; the weekly workflow
  invokes them directly.
- `scripts/exiftool.sls` resolves its version and hash over the network at render time
  (PR #195). See the section above.
- The default password hash in `config/user/user.sls` is the published SIFT default.
- `sift/pkgs.sls` and `sift/vm.sls` are legacy aliases for `sift.server` / `sift.desktop`,
  kept for older tooling.

**Real limitations:**

- Two state-ID naming conventions coexist in `packages/` (bare `<name>:` and
  `sift-package-<name>:`). Not unifiable without breaking requisites that reference IDs.
- The header comment block is on roughly a quarter of `packages/`. Add it to files you
  touch; a tree-wide backfill would need per-tool research.
- `skip_verify: True` survives in four places: `repos/microsoft.sls` and `repos/docker.sls`
  fetch GPG keys that upstream rotates, and `scripts/zimmerman.sls` and
  `python3-packages/machinae.sls` pull rolling "latest" artifacts with no stable checksum
  to pin. Each is a real gap for a forensics distro, but pinning them as-is would break
  installs on the next upstream refresh. Don't add new ones.
- `scripts/zimmerman.sls` relies on Salt's declaration-order execution rather than explicit
  requisites between its download, extract, wrapper and cleanup states. It works because
  `state_auto_order` defaults on, but it is fragile.
- Renovate cannot manage dual-arch hashes or non-GitHub-hosted downloads. See the
  version-pinning section for which files that affects and why.

## Things not to do

- Don't bundle multiple tools into one `.sls` — it defeats per-state CI.
- Don't mass-rename state IDs to unify the two naming conventions; requisites reference
  IDs by name.
- Don't `pip install` or `cpanm` into system paths without the established venv pattern.
- Don't add `skip_verify: True` or unpinned downloads.
- Don't add render-time `salt['http.query']` lookups.
- Don't hardcode `amd64` or an Ubuntu codename — branch on grains.
- Don't change the default password hash in `sift/config/user/user.sls`; it is the
  documented, public SIFT default and tooling depends on it.
- Don't assume registering a state in `init.sls` gets it tested — CI filters `init.sls`
  out. Run it locally with `.ci/test-state.sh`.
