{% if grains['oscodename'] == 'focal' %}
sift-package-libicu66:
  pkg.installed:
    - name: libicu66
{% elif grains['oscodename'] == 'jammy' %}
sift-package-libicu70:
  pkg.installed:
    - name: libicu70
{% endif %}
