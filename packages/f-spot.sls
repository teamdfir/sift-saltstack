{%- if grains['oscodename'] == "trusty" -%}
f-spot:
  pkg.installed
{%- endif -%}
