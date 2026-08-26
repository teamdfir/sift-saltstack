# Name: Mulder
# Website: https://github.com/calebevans/mulder
# Description: Autonomous DFIR platform that analyses disk images, memory dumps, PCAPs and event logs, producing incident reports with MITRE ATT&CK mappings and IOC exports.
# Category:
# Author: Caleb Evans
# License: Apache License 2.0 (https://github.com/calebevans/mulder/blob/main/LICENSE)
# Notes: mulder, mulder-dfir
#
# Upstream now publishes mulder-dfir on PyPI, so this installs natively instead of baking
# in the 3.6 GB container image this state used to fetch. Both console scripts are the
# same entry point:
#
#   mulder investigate /cases my-case      # /cases is SIFT's evidence root
#   mulder report my-case                  # markdown + HTML + PDF
#   mulder export-iocs my-case             # STIX by default
#
# Registered in python3-packages/init.sls, so this ships on every image. Mulder still
# needs an LLM provider credential to do anything (ANTHROPIC_API_KEY, `claude /login`, or
# the Bedrock/Vertex variables) and sends evidence content to whichever provider is
# configured -- installing it does not, by itself, transmit anything. It was opt-in until
# the commit that registered it, so older discussion says otherwise.
#
# `mulder setup` fetches the ~2.2 GB pip cannot ship -- MITRE ATT&CK, Sigma, the YARA
# signature-base, the Didier Stevens suite, Chainsaw, Hayabusa, Zircolite, capa, FLOSS,
# the EZ Tools mulder invokes, ALEAPP/iLEAPP, and the Volatility 3 symbol packs. Upstream
# pins those versions per release, so pinning mulder pins the assets too -- but note they
# are not hash-verified here the way the rest of the tree pins its downloads.
#
# They land in /opt/mulder-assets rather than a home directory so every account on the
# image can read them. That means MULDER_ASSET_ROOT has to be set at run time as well as
# at setup time, which is why /usr/local/bin gets wrappers instead of plain symlinks.
# Setting it also disables mulder's own /opt search, which costs nothing: SIFT ships none
# of these assets under /opt. The one overlap is EZ Tools, and mulder keeps its own copy
# alongside /opt/zimmermantools.
#
# Two things setup writes outside that root stay per-user: the Volatility 3 symbol packs,
# which go to $HOME/.cache/volatility3 where Volatility looks for them (so SIFT's own
# /opt/volatility3 benefits as well), and the tool shims it reports under ~/.local/bin.
# Both belong to whichever account ran setup. Mulder resolves the assets by path, so a
# second account on the image can still use it -- it just does not get the shims.
#
# `mulder setup` refuses to run as root: a root-owned signature-base makes git's
# dubious-ownership check fail for every later non-root run. CI applies every state with
# sift_user=root, so the asset step is skipped there and the rest of this state -- venv,
# pinned install, wrappers -- is what gets CI coverage. Verify the asset step by hand on
# a real target.
#
# The venv carries its own volatility3 (a mulder-dfir dependency), independent of SIFT's
# /opt/volatility3.
#
# libewf comes from gift, which is authoritative for libyal here (see AGENTS.md). Upstream
# builds libewf-experimental 20240506 into /usr/local; doing that on a SIFT image would
# shadow gift's libewf for sleuthkit, plaso and dfvfs, so this takes gift's libewf-tools
# for ewfmount instead -- only a fallback anyway, since TSK icat reads E01 directly. gift
# ships no libewf on jammy/arm64, hence the guard below; ewfmount is simply absent there.
#
# Docs: https://github.com/calebevans/mulder/blob/main/docs/usage-guide.md

{# renovate: datasource=pypi depName=mulder-dfir #}
{%- set version = "1.4.0" -%}
{%- set spec = "mulder-dfir[forensics,pdf,stix]" -%}
{%- set asset_root = "/opt/mulder-assets" -%}
{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- set user_info = salt['user.info'](user) -%}
{%- set arm64 = grains['osarch'] in ['aarch64', 'arm64'] -%}
{%- set gift_libewf = not (arm64 and grains['oscodename'] == 'jammy') -%}

include:
  - sift.packages.python3-virtualenv
  # `mulder setup` clones six of its assets, and the YARA signature-base needs a real .git
  - sift.packages.git
  # upstream's apt line: SIFT already has all of these but the yara binary
  - sift.packages.yara
  - sift.packages.sleuthkit
  - sift.packages.p7zip-full
  - sift.packages.binutils
{%- if gift_libewf %}
  # ewfmount for the E01 fallback in extractors/disk.py -- gift's build, NOT upstream's
  # source install into /usr/local. See the note above.
  - sift.packages.libewf-tools
{%- endif %}
  # weasyprint (the pdf extra) dlopens these at run time; pip installs fine without them
  - sift.packages.libpango
  - sift.packages.libharfbuzz
  # the runtime claude-agent-sdk drives
  - sift.packages.claude-code

sift-python3-package-mulder-venv:
  virtualenv.managed:
    - name: /opt/mulder
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

# No `upgrade: True` here -- it would fight the pin above.
sift-python3-package-mulder:
  pip.installed:
    - name: '{{ spec }}=={{ version }}'
    - bin_env: /opt/mulder/bin/python3
    - require:
      - virtualenv: sift-python3-package-mulder-venv
      - sls: sift.packages.git
      - sls: sift.packages.yara
      - sls: sift.packages.sleuthkit
      - sls: sift.packages.p7zip-full
      - sls: sift.packages.binutils
{%- if gift_libewf %}
      - sls: sift.packages.libewf-tools
{%- endif %}
      - sls: sift.packages.libpango
      - sls: sift.packages.libharfbuzz
      - sls: sift.packages.claude-code

# Wrappers rather than symlinks: the asset root has to be exported for every invocation,
# including `mulder serve` when an MCP client starts it.
{% for script in ['mulder', 'mulder-dfir'] %}
sift-python3-package-mulder-wrapper-{{ script }}:
  file.managed:
    - name: /usr/local/bin/{{ script }}
    - mode: 755
    - force: True
    - makedirs: False
    - contents: |
        #!/bin/bash
        # SIFT wrapper for {{ script }}.
        # Managed by sift.python3-packages.mulder -- local edits will be overwritten.
        export MULDER_ASSET_ROOT="${MULDER_ASSET_ROOT:-{{ asset_root }}}"
        exec /opt/mulder/bin/{{ script }} "$@"
    - require:
      - pip: sift-python3-package-mulder
{% endfor %}

{% if user == 'root' %}

# The CI path, and any other root pillar. Upstream will not provision assets as root, so
# this is the one case where the state completes without them -- said out loud rather than
# guarded silently, because a build that ships an empty mulder and reports success is
# worse than one that reports why it did not.
sift-python3-package-mulder-assets-skipped:
  test.show_notification:
    - text: |
        mulder setup was NOT run: sift_user is root, and `mulder setup` refuses to run as
        root (a root-owned signature-base breaks git's dubious-ownership check for every
        later non-root run). Mulder is installed but has none of its ~2.2 GB of assets.
        Provision them by hand as a normal user:

          sudo install -d -o <user> -g <user> -m 755 {{ asset_root }}
          MULDER_ASSET_ROOT={{ asset_root }} mulder setup
    - require:
      - pip: sift-python3-package-mulder

{% elif not user_info %}

sift-python3-package-mulder-assets-no-user:
  test.fail_without_changes:
    - name: >-
        sift_user '{{ user }}' does not exist, so `mulder setup` has no account to run as
        and mulder's assets cannot be provisioned. Create the account first, or apply this
        state with a pillar naming an existing non-root user.
    - require:
      - pip: sift-python3-package-mulder

{% else %}

sift-python3-package-mulder-asset-root:
  file.directory:
    - name: {{ asset_root }}
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - makedirs: True

# `mulder setup --verify` is upstream's read-only check: exit 0 when every pinned asset is
# present and valid, exit 4 when anything is missing, and no network requests either way.
# That makes it an exact idempotency guard for the fetch. --yes is required because setup
# prompts before downloading more than 1 GB and cmd.run is not interactive.
sift-python3-package-mulder-assets:
  cmd.run:
    - name: /opt/mulder/bin/mulder setup --yes
    - runas: {{ user }}
    - cwd: {{ asset_root }}
    - env:
      - MULDER_ASSET_ROOT: {{ asset_root }}
      - HOME: {{ user_info['home'] }}
    - unless: /opt/mulder/bin/mulder setup --verify
    - timeout: 3600
    - require:
      - pip: sift-python3-package-mulder
      - file: sift-python3-package-mulder-asset-root

{% endif %}
