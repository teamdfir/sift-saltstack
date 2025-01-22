{% if grains['oscodename'] == 'jammy' %}
  {% set package = 'libicu70' %}
{% elif grains['oscodename'] == 'noble' %}
  {% set package = 'libicu74' %}
{% endif %}
sift-package-libicu:
  pkg.installed:
    - name: {{ package }}
