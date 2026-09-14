# Name: Docker Compose
# Website: https://docs.docker.com/compose/
# Description: Define and run multi-container Docker applications
# Category:
# Author: Docker Inc.
# License: Apache License 2.0 (https://github.com/docker/compose/blob/main/LICENSE)
# Notes: docker-compose

{# renovate: datasource=github-release-attachments depName=docker/compose #}
{%- set version = "2.32.4" -%}
{%- set asset = "docker-compose-" ~ grains['kernel']|lower ~ "-" ~ grains['cpuarch'] -%}
{%- set base_url = "https://github.com/docker/compose/releases/download/v" -%}

sift-scripts-docker-compose:
  file.managed:
    - name: /usr/local/bin/docker-compose
    - source: "{{ base_url }}{{ version }}/{{ asset }}"
    - source_hash: "{{ base_url }}{{ version }}/{{ asset }}.sha256"
    - mode: 755
    - replace: True
