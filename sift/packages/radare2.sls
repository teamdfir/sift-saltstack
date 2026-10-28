# Name: radare2
# Website: https://www.radare.org/n/radare2.html
# Description: Examine binary files, including disassembling and debugging. Includes r2ai and decai plugins for LLM-powered analysis (API key or local Ollama required), plus the r2ghidra plugin for Ghidra decompilation via the pdg command.
# Category: 
# Author: https://github.com/radareorg/radare2/blob/master/AUTHORS.md
# License: GNU Lesser General Public License (LGPL) v3: https://github.com/radareorg/radare2/blob/master/COPYING
# Notes: r2, rasm2, rabin2, rahash2, rafind2, r2ai, decai, pdg

{# renovate: datasource=github-release-attachments depName=radareorg/radare2 #}
{%- set version = "6.2.4" -%}
{%- set osarch = grains["osarch"] %}
{%- set base_url = "https://github.com/radareorg/radare2/releases/download/" -%}
{%- if osarch == "aarch64" or osarch == "arm64" -%}
  {%- set hash = "bbf48ee7bd5d8282f65a297dcabd34c9961a500e62d6b036679caab187b32ef1" -%}
  {% set dev_hash = '09e4e50be48e3dc79b541a37f3bf1ee6ef21e33c5005b9cf232fa41952d74ade' %}
  {% set r2ghidra_hash = 'a8ac843c4e23e6cbf3c4e0975d84215f4706172109130fa0ee2229bc56faec26' %}
  {%- set filename = "radare2_" ~ version ~ "_arm64.deb" -%}
{%- else -%}
  {%- set hash = "7019eedc0e0e87d1f53d6b8f5fc62b898567679c5efdce7fbfc557c9e7655e90" -%}
  {% set dev_hash = 'cec4832762c4d0a029f78e724ce6a0d83cf8f04fe8ae5f69b50486983c08e347' %}
  {% set r2ghidra_hash = 'e5c184cc6943f5e99bcb1ecc2f3bdf200e58865eea01edfbfb787b0e476ea385' %}
  {%- set filename = "radare2_" ~ version ~ "_amd64.deb" -%}
{%- endif -%}
{% set user = salt['pillar.get']('sift_user', 'sansforensics') %}
{% if user == "root" %}
  {% set home = "/root" %}
{% else %}
  {% set home = "/home/" + user %}
{% endif %}
{% set installed_version = salt['cmd.shell']("dpkg-query -W -f='${Version}' radare2 2>/dev/null || true") %}

include:
  - sift.config.user.user
  - sift.packages.curl
  - sift.packages.build-essential
  - sift.packages.pkg-config

{% if installed_version != '' and installed_version > version %}
Installed Version {{ installed_version }} is higher than intended version:
  test.nop
{% else %}

sift-package-radare2-download:
  file.managed:
    - name: /var/cache/sift/archives/{{ filename }}
    - source: "{{ base_url }}{{ version }}/{{ filename }}"
    - source_hash: sha256={{ hash }}
    - makedirs: True

sift-package-radare2:
  pkg.installed:
    - sources:
      - radare2: /var/cache/sift/archives/{{ filename }}
    - watch:
      - file: sift-package-radare2-download

{% if osarch == "amd64" %}

sift-package-r2ghidra-source:
  file.managed:
    - name: /usr/local/src/r2ghidra_{{ version }}_{{ osarch }}.deb
    - source: https://github.com/radareorg/r2ghidra/releases/download/{{ version }}/r2ghidra_{{ version }}_{{ osarch }}.deb
    - source_hash: sha256={{ r2ghidra_hash }}
    - require:
      - pkg: sift-package-radare2

sift-package-r2ghidra:
  pkg.installed:
    - sources:
      - r2ghidra: /usr/local/src/r2ghidra_{{ version }}_{{ osarch }}.deb
    - watch:
      - file: sift-package-r2ghidra-source
    - require:
      - pkg: sift-package-radare2

{% elif osarch == "arm64" %}

sift-package-r2ghidra-source:
  file.managed:
    - name: /usr/local/src/r2ghidra-{{ version }}-linux-arm-64.zip
    - source: https://github.com/radareorg/r2ghidra/releases/download/{{ version }}/r2ghidra-{{ version }}-linux-arm-64.zip
    - source_hash: sha256={{ r2ghidra_hash }}
    - require:
      - pkg: sift-package-radare2

sift-package-r2ghidra-archive:
  archive.extracted:
    - name: /opt/r2ghidra/{{ version }}
    - source: /usr/local/src/r2ghidra-{{ version }}-linux-arm-64.zip
    - enforce_toplevel: False
    - require:
      - file: sift-package-r2ghidra-source

sift-package-r2ghidra-plugin:
  file.symlink:
    - name: /usr/lib/radare2/{{ version }}/core_ghidra.so
    - target: /opt/r2ghidra/{{ version }}/plugins/core_ghidra.so
    - makedirs: True
    - force: True
    - require:
      - archive: sift-package-r2ghidra-archive

sift-package-r2ghidra-sleigh:
  file.symlink:
    - name: /usr/lib/radare2/{{ version }}/r2ghidra_sleigh
    - target: /opt/r2ghidra/{{ version }}/plugins/r2ghidra_sleigh
    - makedirs: True
    - force: True
    - require:
      - archive: sift-package-r2ghidra-archive

{% for bin in ['sleighc', 'r2fidb'] %}
sift-package-r2ghidra-{{ bin }}:
  file.symlink:
    - name: /usr/local/bin/{{ bin }}
    - target: /opt/r2ghidra/{{ version }}/bin/{{ bin }}
    - force: True
    - require:
      - archive: sift-package-r2ghidra-archive
{% endfor %}
{% endif %}

sift-package-radare2-r2pm-update:
  cmd.run:
    - name: r2pm -U
    - runas: {{ user }}
    - cwd: {{ home }}
    - env:
      - HOME: {{ home }}
    - unless: test -d {{ home }}/.local/share/radare2/r2pm/git/radare2-pm
    - require:
      - user: sift-user-{{ user }}

sift-package-radare2-dev-source:
  file.managed:
    - name: /usr/local/src/radare2-dev_{{ version }}_{{ osarch }}.deb
    - source: https://github.com/radareorg/radare2/releases/download/{{ version }}/radare2-dev_{{ version }}_{{ osarch }}.deb
    - source_hash: sha256={{ dev_hash }}
    - require:
      - cmd: sift-package-radare2-r2pm-update

sift-package-radare2-dev-install:
  cmd.run:
    - name: dpkg -i /usr/local/src/radare2-dev_{{ version }}_{{ osarch }}.deb
    - unless: test "$(cat {{ home }}/.local/share/radare2/plugins/.r2ai-radare2-version 2>/dev/null)" = "{{ version }}"
    - require:
      - file: sift-package-radare2-dev-source
      - user: sift-user-{{ user }}

sift-package-radare2-r2ai-install:
  cmd.run:
    - name: r2pm -ci r2ai && r2pm -ci decai && mkdir -p {{ home }}/.local/share/radare2/plugins && echo '{{ version }}' > {{ home }}/.local/share/radare2/plugins/.r2ai-radare2-version
    - runas: {{ user }}
    - cwd: {{ home }}
    - env:
      - HOME: {{ home }}
    - unless: test "$(cat {{ home }}/.local/share/radare2/plugins/.r2ai-radare2-version 2>/dev/null)" = "{{ version }}"
    - require:
      - cmd: sift-package-radare2-dev-install
      - pkg: build-essential
      - pkg: pkg-config
      - sls: sift.packages.curl
      - user: sift-user-{{ user }}

sift-package-radare2-dev-cleanup:
  cmd.run:
    - name: dpkg -r radare2-dev
    - onlyif: dpkg -l radare2-dev 2>/dev/null | grep -q ^ii
    - require:
      - cmd: sift-package-radare2-r2ai-install

sift-package-radare2-plugin-ownership:
  file.directory:
    - name: {{ home }}/.local/share/radare2
    - user: {{ user }}
    - group: {{ user }}
    - recurse:
      - user
      - group
    - require:
      - cmd: sift-package-radare2-dev-cleanup
      - user: sift-user-{{ user }}
{% endif %}
