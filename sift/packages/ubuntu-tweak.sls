{%- if grains['oscodename'] != "xenial" -%}
ubuntu-tweak:
  pkg.installed
{%- endif %}
