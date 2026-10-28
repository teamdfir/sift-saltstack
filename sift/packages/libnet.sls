{% if grains['oscodename'] == 'resolute' %}
  {% set package = 'libnet9' %}
{% else %}
  {% set package = 'libnet1' %}
{% endif %}

sift-package-libnet:
  pkg.installed:
    - name: {{ package }}
