{% if grains['oscodename'] == 'resolute' %}
sift-package-pev:
  test.nop:
    - name: pev is not available on ubuntu resolute
{% else %}

sift-package-pev:
  pkg.installed:
    - name: pev

{% endif %}
