# Name: MaldocTrace
# Website: https://github.com/debugactiveprocess/MaldocTrace
# Description: Static analyzer and safe VBA emulator for malicious Office documents
# Category:
# Author: debugactiveprocess
# License: Apache License 2.0 (https://github.com/debugactiveprocess/MaldocTrace/blob/main/LICENSE)
# Notes: maldoctrace

{% set version = "0.4.0" -%}
{%- if grains["osarch"] == "aarch64" or grains["osarch"] == "arm64" -%}
{%- set arch = "arm64" -%}
{%- set hash = "3beeb0b85f8902d01985f05dc5333e4666c4d986a2912337e22bad59df5fa49a" -%}
{%- else -%}
{%- set arch = "amd64" -%}
{%- set hash = "26f5c1177c571c9056dc55bf01b30abeaf056b371c79d61f7b7e58328df1d1ba" -%}
{%- endif -%}
{%- set folder = "maldocTrace_" ~ version ~ "_linux_" ~ arch -%}
{%- set filename = folder ~ ".tar.gz" -%}
{%- set base_url = "https://github.com/debugactiveprocess/MaldocTrace/releases/download/v" -%}

sift-scripts-maldoctrace-source:
  file.managed:
    - name: /var/cache/sift/archives/{{ filename }}
    - source: "{{ base_url }}{{ version }}/{{ filename }}"
    - source_hash: sha256={{ hash }}
    - makedirs: True

sift-scripts-maldoctrace-archive:
  archive.extracted:
    - name: /opt/maldoctrace
    - source: /var/cache/sift/archives/{{ filename }}
    - force: True
    - watch:
      - file: sift-scripts-maldoctrace-source

sift-scripts-maldoctrace:
  file.symlink:
    - name: /usr/local/bin/maldoctrace
    - target: /opt/maldoctrace/{{ folder }}/maldocTrace
    - force: True
    - require:
      - archive: sift-scripts-maldoctrace-archive
