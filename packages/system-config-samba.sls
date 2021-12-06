# system-config-samba was a GUI available in bionic and below for configuring samba
{%- if grains['oscodename'] == "bionic" %}
system-config-samba:
  pkg.installed
{%- else %}
system-config-samba:
  test.nop
{%- endif %}