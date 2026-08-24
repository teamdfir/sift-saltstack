# Name: MemProcFS
# Website: https://github.com/ufrisk/MemProcFS
# Description: Memory Process File System
# Author: Ulf Frisk
# License: GNU Affero General Public License v3.0
# Version: 5.18.4
# Release Date: 20260812

{%- set version = '5.18.4' -%}
{%- set release_date = '20260812' -%}
{%- set arch = "x64" -%}
{%- set hash = '44bd35aa7f7692c7261213035cc7838247c2afab9776f7aa2628b1408b25af5d' -%}

{# Logic to switch to ARM64/AARCH64 if detected #}
{%- if grains["osarch"] == "aarch64" or grains["osarch"] == "arm64" -%}
  {%- set arch = "aarch64" -%}
  {%- set hash = '666714671c817f9ebd5e70cfc5cdf8f61f6e9919c94ea2faf1526119aec0e93d' -%}
{%- endif %}

memprocfs-deps:
  pkg.installed:
    - pkgs:
      - fuse3
      - libfuse3-dev
      - liblz4-1
      - libusb-1.0-0
      - libfuse2t64

sift-package-memprocfs-directory:
  file.directory:
    - name: /opt/memprocfs
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

sift-package-memprocfs-archive:
  archive.extracted:
    - name: /opt/memprocfs
    - source: https://github.com/ufrisk/MemProcFS/releases/download/v5_archive/MemProcFS_files_and_binaries_v{{ version }}-linux_{{ arch }}-{{ release_date }}.tar.gz
    - source_hash: sha256={{ hash }}
    - archive_format: tar
    - options: --strip-components=1
    - enforce_toplevel: False
    - overwrite: True
    - require:
      - pkg: memprocfs-deps
      - file: sift-package-memprocfs-directory

sift-package-memprocfs-executable:
  file.managed:
    - name: /opt/memprocfs/memprocfs
    - mode: 755
    - replace: False
    - require:
      - archive: sift-package-memprocfs-archive

sift-package-memprocfs-symlink:
  file.symlink:
    - name: /usr/local/bin/memprocfs
    - target: /opt/memprocfs/memprocfs
    - force: True
    - require:
      - file: sift-package-memprocfs-executable
