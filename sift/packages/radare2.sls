{# renovate: datasource=github-release-attachments depName=radareorg/radare2 #}
{%- set version = "5.9.2" -%}
{%- set hash = "b33826fb482d40fe9b1b9698f117153fd3e78a9ffff19f6085ce225b99e72f12" -%}
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
