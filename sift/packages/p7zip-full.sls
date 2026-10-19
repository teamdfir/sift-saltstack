{% if grains['oscodename'] == 'resolute' %}
{% set package = '7zip' %}
{% else %}
{% set package = 'p7zip-full' %}
{% endif %}

sift-package-{{ package }}:
  pkg.installed:
    - name: {{ package }}
