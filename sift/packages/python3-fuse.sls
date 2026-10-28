{% if grains['oscodename'] == 'resolute' %}
python3-fuse is not available in Ubuntu Resolute:
  test.nop
{% else %}

sift-package-python3-fuse:
  pkg.installed:
    - name: python3-fuse

{% endif %}
