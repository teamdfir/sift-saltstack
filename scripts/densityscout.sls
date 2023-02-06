# http://cert.at/static/downloads/software/densityscout/densityscout_build_45_linux.zip

{% set build = "45" %}
{% set hash = "7d49813d407df06529e4b0138d4c0eec725c73bf9e93c0444639c6d409890f2c" %}

sift-tool-densityscout-archive:
  archive.extracted:
    - name: /usr/local/src/densityscout/densityscout_build_{{ build }}_linux
    - enforce_toplevel: False
    - source: https://cert.at/media/files/downloads/software/densityscout/files/densityscout_build_{{ build }}_linux.zip
    - source_hash: sha256={{ hash }}
    - if_missing: /usr/local/bin/densityscout-build-{{ build }}

sift-tool-densityscout-binary:
  file.copy:
    - name: /usr/local/bin/densityscout-build-{{ build }}
    - source: /usr/local/src/densityscout/densityscout_build_{{ build }}_linux/lin64/densityscout
    - user: root
    - group: root
    - force: True
    - mode: 755
    - require:
      - archive: sift-tool-densityscout-archive

sift-tool-densityscout-link:
  file.symlink:
    - name: /usr/local/bin/densityscout
    - target: /usr/local/bin/densityscout-build-{{ build }}
    - require:
      - file: sift-tool-densityscout-binary
