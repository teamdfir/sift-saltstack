# Name: MemProcFS
# Website: https://github.com/ufrisk/MemProcFS
# Description: Memory Process File System
# Author: Ulf Frisk
# License: GNU General Public License v3.0
# Version: 5.17.5
# Release Date: 20260415

{%- set version = '5.17.5' -%}
{%- set release_date = '20260415' -%}
{%- set arch = "x64" -%}
{%- set hash = 'd614745dcdd2bd2039f459f964de84c175dc022ce95adc1190ac0f9ab673fa7d' -%}

{# Logic to switch to ARM64/AARCH64 if detected #}
{%- if grains["osarch"] == "aarch64" or grains["osarch"] == "arm64" -%}
  {%- set arch = "aarch64" -%}
  {%- set hash = '307183bab25337afb307857b6d8e8f11ed4846818343725743ec257bcf6992d0' -%}
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
