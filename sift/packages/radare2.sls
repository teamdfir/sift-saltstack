{# renovate: datasource=github-release-attachments depName=radareorg/radare2 #}
{%- set version = "5.9.8" -%}
{%- set hash = "6c6dec5f769d7b7ac35c9d5ebf850be66c4650874dfb4319d3ede26d20ae5c39" -%}
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
