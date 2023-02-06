{%- set base_url = "https://github.com/radareorg/radare2/releases/download/" -%}
{%- set version = "5.7.6" -%}
{%- set filename = "radare2_5.7.6_amd64.deb" -%}
{%- set hash = "90b76ac2617895f48d33486ae9c9ea08333f5daf5298a76f5172b2648a071d0f" -%}

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
