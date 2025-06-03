{%- if grains["oscodename"] == "noble" -%}
sift-rar:
  test.nop
{%- else -%}
include:
  - sift.repos.ubuntu-multiverse

sift-rar:
  pkg.installed:
    - name: rar
    - require:
      - sls: sift.repos.ubuntu-multiverse
{%- endif -%}
