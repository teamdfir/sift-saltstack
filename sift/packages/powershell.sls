{%- set base_url = "https://github.com/Powershell/Powershell/releases/download/v" -%}
{%- set version = "6.0.0-alpha.13" -%}
{%- set filename = "powershell_6.0.0-alpha.13-1ubuntu1." ~ grains['osrelease'] ~ ".1_amd64.deb" -%}

sift-powershell-source:
  file.managed:
    - name: /var/cache/sift/archives/{{ filename }}
    - source: "{{ base_url }}{{ version }}/{{ filename }}"
    - source_hash: sha256=719fc2d42486f4fe123156e9b4380929c6dd28cb6ccbf928ba746020c1caea58
    - makedirs: True

sift-powershell:
  pkg.installed:
    - sources:
      - powershell: /var/cache/sift/archives/{{ filename }}
    - watch:
      - file: sift-powershell-source
