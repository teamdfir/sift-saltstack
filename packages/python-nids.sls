{%- if grains['oscodename'] == "bionic" %}
python-nids:
  pkg.installed
{%- else %}
python-nids:
  test.nop
{%- endif %}