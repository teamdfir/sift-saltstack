{# renovate: datasource=github-release-attachments depName=radareorg/radare2 #}
{%- set version = "5.8.8" -%}
{%- set hash = "691e510a900852d0b818f026bc111d0da24563ea414d569fa83737db57944e2e" -%}
{%- set filename = "radare2_" ~ version ~ "_amd64.deb" -%}
{%- set base_url = "https://github.com/radareorg/radare2/releases/download/" -%}

sift-package-radare2-download:
  file.managed:
    - name: /var/cache/sift/archives/{{ filename }}
    - source: "{{ base_url }}{{ version }}/{{ filename }}"
    - source_hash: sha256={{ hash }}
    - makedirs: True

sift-radare2:
  pkg.installed:
    - sources:
      - radare2: /var/cache/sift/archives/{{ filename }}
    - watch:
      - file: sift-package-radare2-download
