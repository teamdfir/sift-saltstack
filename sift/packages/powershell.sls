{%- set base_url = "https://github.com/Powershell/Powershell/releases/download/v" -%}
{%- set version = "7.2.6" -%}
{%- set filename = "powershell_7.2.6-1.deb_amd64.deb" -%}
{%- set hash = "A0D810FE381B77E4BFB99CC67F713F6D483545E94BDEB4150524C085CF20E2DA" -%}

include:
  - sift.packages.libicu

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
    - require:
      - sls: sift.packages.libicu
