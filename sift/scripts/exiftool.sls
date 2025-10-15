# Name: exiftool
# Website: https://exiftool.org
# Description: Platform-independent tool to read, write, and edit metadata information
# Category:
# Author: Phil Harvey
# License: Free
# Notes: exiftool

{% set exiftool_version = '13.38' -%}
{% set exiftool_sha256  = '0256672ab507662fe42d1ae851ae1b55930a3c8eb69e9d6883c33559e90f5f01' -%}

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


  
