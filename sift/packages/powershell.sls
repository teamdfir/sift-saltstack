# Name: PowerShell
# Website: https://microsoft.com/powershell
# Description: Linux package for PowerShell
# Category:
# Author: Microsoft
# License: MIT License (https://github.com/PowerShell/PowerShell/blob/master/LICENSE.txt)
# Notes:

{# renovate: datasource=github-release-attachments depName=Powershell/Powershell #}
{%- set version = "7.4.6" -%}
{%- set hash = "79642721f0bc9baf07dafaab68ece1cbd822f86722492acf9b4031d41029a735" -%}
{%- set filename = "powershell_" ~ version ~ "-1.deb_amd64.deb" -%}
{%- set base_url = "https://github.com/Powershell/Powershell/releases/download/v" -%}

include:
  - sift.packages.libicu

sift-package-powershell-source:
  file.managed:
    - name: /var/cache/sift/archives/{{ filename }}
    - source: "{{ base_url }}{{ version }}/{{ filename }}"
    - source_hash: sha256={{ hash }}
    - makedirs: True

sift-package-powershell:
  pkg.installed:
    - sources:
      - powershell: /var/cache/sift/archives/{{ filename }}
    - watch:
      - file: sift-package-powershell-source
    - require:
      - sls: sift.packages.libicu
