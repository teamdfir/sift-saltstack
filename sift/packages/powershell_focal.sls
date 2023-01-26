{%- set version = "7.3.2" -%}
{%- set base_url = "https://github.com/Powershell/Powershell/releases/download/v" ~ version -%}
{%- set filename = "powershell_" ~ version ~ "-1.deb_amd64.deb" -%}

sift-powershell-focal:
  pkg.installed:
    - sources:
      - powershell: {{ base_url }}/{{ filename }}
