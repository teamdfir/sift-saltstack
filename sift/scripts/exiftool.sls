# Name: exiftool
# Website: https://exiftool.org
# Description: Platform-independent tool to read, write, and edit metadata information
# Category:
# Author: Phil Harvey
# License: Free
# Notes: exiftool

{% set exiftool_version = '13.43' -%}
{% set exiftool_sha256  = '1beef514c895705b3e3eafea3602db6b4830697f37b997b6ae9795cdfa2608d1' -%}

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


  
