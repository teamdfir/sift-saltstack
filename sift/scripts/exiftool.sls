# Name: exiftool
# Website: https://exiftool.org
# Description: Platform-independent tool to read, write, and edit metadata information
# Category:
# Author: Phil Harvey
# License: Free
# Notes: exiftool

{% set version_query = salt['http.query']('https://exiftool.org/ver.txt', backend='requests', verify_ssl=True) %}
{% set exiftool_version = version_query.get('body').strip() %}
{% set hash_query = salt['http.query']('https://exiftool.org/checksums.txt', backend='requests', verify_ssl=True) %}
{% set hash_content = hash_query.get('body').splitlines() %}
{% set ns = namespace(exiftool_sha256='') %}
{% for line in hash_content %}
{% if 'SHA2-256(Image-ExifTool-' ~ exiftool_version ~ '.tar.gz)' in line %}
{% set ns.exiftool_sha256 = line.split()[-1].strip() %}
{% endif %}
{% endfor %}

include:
  - sift.packages.build-essential

sift-exiftool-source:
  file.managed:
    - name: /var/cache/sift/archives/Image-ExifTool-{{ exiftool_version }}.tar.gz
    - source: https://exiftool.org/Image-ExifTool-{{ exiftool_version }}.tar.gz
    - source_hash: sha256={{ ns.exiftool_sha256 }}
    - makedirs: True

sift-exiftool-extracted:
  archive.extracted:
    - name: /usr/local/src/exiftool-{{ exiftool_version }}
    - source: /var/cache/sift/archives/Image-ExifTool-{{ exiftool_version }}.tar.gz
    - source_hash: sha256={{ ns.exiftool_sha256 }}
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


  
