{% if grains['oscodename'] == 'resolute' %}
outguess is not available on Ubuntu Resolute:
  test.nop
{% else %}

sift-package-outguess:
  pkg.installed:
    - name: outguess

{% endif %}
