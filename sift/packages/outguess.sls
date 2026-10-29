{% if grains['oscodename'] == 'resolute' %}
sift-package-outguess:
  test.nop:
    - name: outguess is not available on ubuntu resolute
{% else %}

sift-package-outguess:
  pkg.installed:
    - name: outguess

{% endif %}
