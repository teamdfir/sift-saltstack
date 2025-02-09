{# renovate: datasource=github-release-attachments depName=Powershell/Powershell #}
{%- set version = "7.5.0" -%}
{%- set hash = "625B7EE0B71147421723CB6022A41B5D8FC0D6E19DF25B1240008EE491BF6997" -%}
{%- set filename = "powershell_" ~ version ~ "-1.deb_amd64.deb" -%}
{%- set base_url = "https://github.com/Powershell/Powershell/releases/download/v" -%}

include:
  - sift.packages.libicu

sift-powershell-source:
  file.managed:
    - name: /var/cache/sift/archives/{{ filename }}
    - source: "{{ base_url }}{{ version }}/{{ filename }}"
    - source_hash: sha256={{ hash }}
    - makedirs: True

sift-powershell:
  pkg.installed:
    - sources:
      - powershell: /var/cache/sift/archives/{{ filename }}
    - watch:
      - file: sift-powershell-source
    - require:
      - sls: sift.packages.libicu
