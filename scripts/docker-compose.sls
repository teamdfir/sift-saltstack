{%- set version = "1.24.0" -%}
{%- set hash = "bee6460f96339d5d978bb63d17943f773e1a140242dfa6c941d5e020a302c91b" -%}

sift-scripts-docker-compose:
  file.managed:
    - name: /usr/local/bin/docker-compose
    - source: https://github.com/docker/compose/releases/download/{{ version }}/docker-compose-{{ grains['kernel'] }}-{{ grains['cpuarch'] }}
    - source_hash: sha256={{ hash }}
    - mode: 755
