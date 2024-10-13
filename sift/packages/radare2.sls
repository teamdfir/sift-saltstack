{# renovate: datasource=github-release-attachments depName=radareorg/radare2 #}
{%- set version = "5.9.6" -%}
{%- set hash = "596c2b2e5cd95f38827f5e29d93547f7535e49c5bba0d5bd845b36f7e2488974" -%}
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
