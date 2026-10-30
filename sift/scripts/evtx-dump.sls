# Name: evtx (evtx_dump)
# Website: https://github.com/omerbenamram/evtx
# Description: Fast, multi-threaded parser for Windows XML Event Log (.evtx) files, to XML, JSON or JSON lines.
# Category:
# Author: Omer Ben-Amram
# License: MIT or Apache License 2.0 (https://github.com/omerbenamram/evtx/blob/master/LICENSE-MIT)
# Notes: evtx_dump
#
# Each release ships a per-arch binary with its own checksum (amd64 is the static musl
# build; arm64 has only a glibc build, which needs glibc 2.18), so the renovate custom
# manager cannot keep this current -- it captures one digest per file. Bump by hand: the
# sha256 of each asset is shown on the release page.
{# no leading '-' on the next tag: it would strip the newline above and splice the last
   comment line onto the state ID below, commenting the whole state out. #}
{% set version = "0.12.3" -%}
{%- set base_url = "https://github.com/omerbenamram/evtx/releases/download/v" -%}
{%- set hash = "d3a5de21677632353ac9b865b45d12a483d2207b1fa05f86c5decd7d5a85a741" -%}
{%- set target = "x86_64-unknown-linux-musl" -%}
{%- if grains["osarch"] == "aarch64" or grains["osarch"] == "arm64" -%}
{%- set hash = "f0e38baf52a2020c69ead437f6858cf8e76d5b99a7893e13f28f0973ef6d7ec5" -%}
{%- set target = "aarch64-unknown-linux-gnu" -%}
{%- endif -%}

sift-scripts-evtx-dump:
  file.managed:
    - name: /usr/local/bin/evtx_dump
    - source: "{{ base_url }}{{ version }}/evtx_dump-v{{ version }}-{{ target }}"
    - source_hash: sha256={{ hash }}
    - mode: 755
    - replace: True
