{%- set base_url = "https://github.com/Powershell/Powershell/releases/download/v" -%}
{%- set version = "6.2.0" -%}
{%- set filename = "powershell_6.2.0-1.ubuntu.18.04_amd64.deb" -%}
{%- set hash = "38dcb2164c1fe3b4f0200aba2d5969c4856526baa1d8983f818cd06003c355ce" -%}

sift-powershell-source:
  file.managed:
    - name: /var/cache/sift/archives/{{ filename }}
    - source: "{{ base_url }}{{ version }}/{{ filename }}"
    - source_hash: sha256={{ hash }}
    - makedirs: True

sift-powershell:
  pkg.installed:
    - sources:
      - powershell: /var/cache/sift/archives/{{ filename }}
    - watch:
      - file: sift-powershell-source
