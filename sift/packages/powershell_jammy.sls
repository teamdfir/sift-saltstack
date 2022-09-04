{%- set base_url = "https://github.com/Powershell/Powershell/releases/download/v" -%}
<<<<<<< HEAD
{%- set version = "6.0.0-alpha.13" -%}
{%- set filename = "powershell_6.0.0-alpha.13-1ubuntu1." ~ grains['osrelease'] ~ ".1_amd64.deb" -%}

sift-powershell:
  test.nop
=======
{%- set version = "7.2.6" -%}
{%- set filename = "powershell_7.2.6-1.deb_amd64.deb" -%}

sift-powershell:
  test.nop
>>>>>>> c09ba8c (Update packages for Jammy compatibility)
