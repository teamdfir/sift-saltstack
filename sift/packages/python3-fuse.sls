{% if grains['oscodename'] == 'resolute' %}
sift-package-python3-fuse:
  test.nop:
    - name: python3-fuse is not available in ubuntu resolute
{% else %}

sift-package-python3-fuse:
  pkg.installed:
    - name: python3-fuse

{% endif %}
