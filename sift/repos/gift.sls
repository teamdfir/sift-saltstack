# The GIFT PPA, written as a DEB822 source with an explicit Signed-By keyring.
#
# This was pkgrepo.managed with `ppa: gift/<channel>`, which shells out to
# add-apt-repository. On jammy that silently produces a ZERO-BYTE .list file whenever
# /etc/apt/sources.list is absent: it still prints "Adding deb entry to ..." and still
# exits 0, so neither Salt nor a human reading the log sees a problem. jammy's
# add-apt-repository cannot parse the DEB822 /etc/apt/sources.list.d/ubuntu.sources that
# sift.repos.ubuntu-universe writes, and that state deletes /etc/apt/sources.list on
# jammy, so any run reaching ubuntu-universe before this state left every gift package
# resolving as "Unable to locate package".
#
# sift.repos.init declares gift second and ubuntu-universe sixth, so full installs escaped
# it on declaration order alone and only isolated state runs broke.
# sift.python3-packages.mulder was the first state to include both (ubuntu-universe via
# sift.packages.yara, this state via sift.packages.libewf-tools). Writing the source file
# directly removes add-apt-repository, and with it the dependency on what shape
# /etc/apt/sources.list happens to be in.
#
# The key is vendored rather than fetched at apply time: it is Launchpad's signing key for
# this PPA (4096R/3ED1EAECE81894B171D7DA5B5E80511B10C598B8, "Launchpad PPA for Google
# Investigative Forensic Toolkit", created 2015-01-06, no expiry), it does not rotate, and
# shipping it keeps this state reproducible and offline-installable without the
# `skip_verify: True` that repos/docker.sls and repos/microsoft.sls still carry for keys
# their upstreams do rotate.

{# No leading dash on the first tag: a {%- here would strip back through the newline and
   splice the comment above onto sift-gift-key, commenting out the first state. #}
{% set version = salt['pillar.get']('sift_version', 'stable') %}
{% set codename = grains['oscodename'] %}
{% set arch = grains['osarch'] | replace('aarch64', 'arm64') %}
{% set other = 'dev' if version == 'stable' else 'stable' %}

sift-gift-key:
  file.managed:
    - name: /usr/share/keyrings/GIFT.asc
    - source: salt://sift/files/apt/gift.asc
    - mode: 644
    - makedirs: True

# Artefacts of the add-apt-repository era, for both channels: the .list file it wrote, and
# the keyring it dropped into trusted.gpg.d, which trusted this PPA for every source on the
# box rather than just for this one. file.absent rather than pkgrepo.absent so that tearing
# the old entries down does not itself go back through add-apt-repository.
{%- for channel in ['stable', 'dev'] %}

sift-gift-legacy-list-{{ channel }}:
  file.absent:
    - name: /etc/apt/sources.list.d/gift-ubuntu-{{ channel }}-{{ codename }}.list

sift-gift-legacy-key-{{ channel }}:
  file.absent:
    - name: /etc/apt/trusted.gpg.d/gift-ubuntu-{{ channel }}.gpg
{%- endfor %}

# Only the selected channel is ever written, so flipping sift_version between stable and
# dev takes the other one away instead of leaving both enabled.
sift-gift-other-channel-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/gift-{{ other }}.sources

sift-gift-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/gift-{{ version }}.sources
    - mode: 644
    - contents: |
        Types: deb
        URIs: https://ppa.launchpadcontent.net/gift/{{ version }}/ubuntu/
        Suites: {{ codename }}
        Components: main
        Architectures: {{ arch }}
        Signed-By: /usr/share/keyrings/GIFT.asc
    - require:
      - file: sift-gift-key
      - file: sift-gift-other-channel-absent
{%- for channel in ['stable', 'dev'] %}
      - file: sift-gift-legacy-list-{{ channel }}
      - file: sift-gift-legacy-key-{{ channel }}
{%- endfor %}

# pkgrepo.managed used to tell Salt the apt cache was stale; writing the source with
# file.managed does not, so without this the first gift package in a run resolves against
# an index that has never seen this repo. Same fix as repos/docker.sls.
sift-gift-repo-refresh:
  module.run:
    - name: pkg.refresh_db
    - onchanges:
      - file: sift-gift-repo

sift-gift-repo-preferences:
  file.managed:
    - name: /etc/apt/preferences.d/gift
    - source: salt://sift/files/apt/gift.preferences
    - template: jinja
    - context:
        version: {{ version }}
    - require:
      - file: sift-gift-repo
