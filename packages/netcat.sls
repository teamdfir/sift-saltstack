{% if grains['oscodename'] == "bionic" -%}
netcat-openbsd:
  pkg.installed
{% else %}
netcat:
  pkg.installed
{%- endif -%}
