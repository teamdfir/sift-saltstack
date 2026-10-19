# Name: PowerShell
# Website: https://microsoft.com/powershell
# Description: Linux package for PowerShell
# Category:
# Author: Microsoft
# License: MIT License (https://github.com/PowerShell/PowerShell/blob/master/LICENSE.txt)
# Notes: pwsh

{%- set osarch = grains["osarch"] -%}
{%- set version = '7.6.6' -%}
{%- set apt_version = version ~ '-1.deb' %}
{%- set hash = '924829e54c983648f6f1419a2dc7f9433c861b2fb5bd57736ff096c24f133729' %}
{%- set installed_version = salt['cmd.shell']("dpkg-query -W -f='${Version}' powershell 2>/dev/null || true").strip('-1.deb') -%}

{% if grains["oscodename"] == "resolute" and osarch == "amd64" %}
PowerShell {{ osarch }} is not yet available on Ubuntu 26.04:
  test.nop
{% else %}

{% if installed_version != '' and installed_version > version %}

Installed version {{ installed_version }} is higher than intended version:
  test.nop

{% elif installed_version != '' and installed_version == version %}

Version {{ installed_version }} is already installed:
  test.nop

{% else %}

include:
  - sift.packages.libicu
{% if osarch == "amd64" %}
  - sift.repos.microsoft

sift-package-powershell:
  pkg.installed:
    - name: powershell={{ apt_version }}
    - require:
      - sls: sift.repos.microsoft
      - sls: sift.packages.libicu

{% else %}
{% set is_installed_locally = salt['file.directory_exists']('/opt/microsoft/powershell/' ~ version) %}
{% if is_installed_locally %}

PowerShell ARM64 version {{ version }} is already installed:
  test.nop

{% else %}

sift-package-powershell-source:
  file.managed:
    - name: /tmp/powershell-{{ version }}-linux-arm64.tar.gz
    - source: https://github.com/PowerShell/PowerShell/releases/download/v{{ version }}/powershell-{{ version }}-linux-arm64.tar.gz
    - source_hash: sha256={{ hash }}
    - makedirs: True
    - require:
      - sls: sift.packages.libicu

sift-package-powershell-archive:
  archive.extracted:
    - name: /opt/microsoft/powershell/{{ version }}
    - source: /tmp/powershell-{{ version }}-linux-arm64.tar.gz
    - enforce_toplevel: False
    - force: True
    - watch:
      - file: sift-package-powershell-source

sift-package-powershell-binary:
  file.managed:
    - name: /opt/microsoft/powershell/{{ version }}/pwsh
    - mode: 755
    - replace: False
    - require:
      - sls: sift.packages.libicu
    - watch:
      - archive: sift-package-powershell-archive

sift-package-powershell-symlink:
  file.symlink:
    - name: /usr/local/bin/pwsh
    - target: /opt/microsoft/powershell/{{ version }}/pwsh
    - force: True
    - require:
      - file: sift-package-powershell-binary

sift-package-powershell-cleanup:
  file.absent:
    - name: /tmp/powershell-{{ version }}-linux-arm64.tar.gz
    - require:
      - archive: sift-package-powershell-archive

{% endif %}
{% endif %}
{% endif %}
{% endif %}
