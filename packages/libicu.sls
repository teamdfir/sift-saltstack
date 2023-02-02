{% if grains['oscodename'] == 'focal' %}
libicu66:
  pkg.installed
{% elif grains['oscodename'] == 'jammy' %}
libicu70:
  pkg.installed
{% endif %}
