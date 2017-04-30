{% if grains['oscodename'] == "trusty" -%}
nautilus-open-terminal:
  pkg.installed
{% endif -%}
