{%- set version = "2.15.1" -%}
{%- set hash = "bcfd9ea51dee4c19dccdfaeef0e7956ef68bf14f3d175933742061a7271ef0f5" -%}

sift-scripts-docker-compose:
  file.managed:
    - name: /usr/local/bin/docker-compose
    - source: https://github.com/docker/compose/releases/download/{{ version }}/docker-compose-{{ grains['kernel'] }}-{{ grains['cpuarch'] }}
    - source_hash: sha256={{ hash }}
    - mode: 755
    - replace: True
