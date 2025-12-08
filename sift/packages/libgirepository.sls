sift-package-libgirepository:
  pkg.installed:
  {% if grains['oscodename'] == "jammy" %}
    - name: libgirepository1.0-dev
  {% elif grains['oscodename'] == "noble" %}
    - name: libgirepository-2.0-dev
  {% endif %}
