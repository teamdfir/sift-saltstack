{% if grains['oscodename'] == 'resolute' %}
pev is not available on Ubuntu Resolute:
  test.nop
{% else %}

sift-package-pev:
  pkg.installed:
    - name: pev

{% endif %}
