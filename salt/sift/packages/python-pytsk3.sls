{%- if grains['oscodename'] == "trusty" -%}
pytsk3:
  pkg.installed
{%- elif grains['oscodename'] == "xenial" -%}
pytsk3-removed:
  pkg.removed:
    - name: pytsk3

pytsk3:
  pkg.installed:
    - name: python-pytsk3
    - required:
      - pkg: pytsk3-removed
{%- endif -%}
