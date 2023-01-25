{%- set base_url = "https://github.com/Powershell/Powershell/releases/download/v" -%}
{%- set version = "6.0.0-alpha.13" -%}
{%- set filename = "powershell_6.0.0-alpha.13-1ubuntu1." ~ grains['osrelease'] ~ ".1_amd64.deb" -%}

sift-powershell:
  test.nop