# source=https://owl.phy.queensu.ca/~phil/exiftool/
# license=free

{% set exiftool_version = '13.01' -%}
{% set exiftool_sha256  = 'ab81649054488b6b7bac79c08bf6cfbfd295ecdf2f20f3db67aabdfc07633391' -%}

include:
  - sift.packages.patch
  
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

sift-exiftool-binary:
  file.managed:
    - name: /usr/local/bin/exiftool
    - source: /usr/local/src/exiftool-{{ exiftool_version }}/Image-ExifTool-{{ exiftool_version }}/exiftool
    - mode: 755


  
