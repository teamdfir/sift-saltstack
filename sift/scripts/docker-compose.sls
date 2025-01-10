{%- set version = "2.23.2" -%}

sift-scripts-docker-compose:
  file.managed:
    - name: /usr/local/bin/docker-compose
    - source: https://github.com/docker/compose/releases/download/v{{ version }}/docker-compose-{{ grains['kernel'] }}-{{ grains['cpuarch'] }}
    - source_hash: https://github.com/docker/compose/releases/download/v{{ version }}/docker-compose-{{ grains['kernel'] }}-{{ grains['cpuarch'] }}.sha256
    - mode: 755
    - replace: True
