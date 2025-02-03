# Name: exiftool
# Website: https://exiftool.org
# Description: Platform-independent tool to read, write, and edit metadata information
# Category:
# Author: Phil Harvey
# License: Free
# Notes: exiftool

{% set exiftool_version = '13.16' -%}
{% set exiftool_sha256  = 'c4d12812ace44caea59173b75c47d97b32fc195dc4c0b561f305d847417839d1' -%}

include:
  - sift.packages.build-essential

sift-exiftool-source:
  file.managed:
    - name: /var/cache/sift/archives/Image-ExifTool-{{ exiftool_version }}.tar.gz
    - source: https://exiftool.org/Image-ExifTool-{{ exiftool_version }}.tar.gz
    - source_hash: sha256={{ exiftool_sha256 }}
    - makedirs: True

sift-exiftool-extracted:
  archive.extracted:
    - name: /usr/local/src/exiftool-{{ exiftool_version }}
    - source: /var/cache/sift/archives/Image-ExifTool-{{ exiftool_version }}.tar.gz
    - source_hash: sha256={{ exiftool_sha256 }}
    - watch:
      - file: sift-exiftool-source

sift-exiftool-makefile:
  cmd.run:
    - name: perl Makefile.PL
    - cwd: /usr/local/src/exiftool-{{ exiftool_version }}/Image-ExifTool-{{ exiftool_version }}/
    - include:
      - sls: sift.packages.build-essential

sift-exiftool-install:
  cmd.run:
    - name: make install
    - cwd: /usr/local/src/exiftool-{{ exiftool_version }}/Image-ExifTool-{{ exiftool_version }}/
    - include:
      - cmd: sift-exiftool-makefile


  
