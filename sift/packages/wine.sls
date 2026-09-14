{% if grains['oscodename'] == 'resolute' %}
  {% set package = 'wine' %}
{% else %}
  {% set package = 'wine-stable' %}
{% endif %}

sift-package-wine:
  pkg.latest:
    - name: {{ package }}
