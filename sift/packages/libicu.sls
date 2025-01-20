{% if grains['oscodename'] == 'focal' %}
sift-package-libicu66:
  pkg.installed:
    - name: libicu66
{% elif grains['oscodename'] == 'jammy' %}
sift-package-libicu70:
  pkg.installed:
    - name: libicu70
{% elif grains['oscodename'] == 'noble' %}
sift-package-libicu74:
  pkg.installed:
    - name: libicu74  
{% endif %}
