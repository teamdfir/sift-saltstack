{% if grains['oscodename'] == 'resolute' %}
sift-package-tcptrace:
  test.nop:
    - name: tcptrace is not available on ubuntu resolute
{% else %}

sift-package-tcptrace:
  pkg.installed:
    - name: tcptrace

{% endif %}
