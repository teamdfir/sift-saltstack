{% if grains['oscodename'] == 'resolute' %}
tcptrace is not available on Ubuntu Resolute:
  test.nop
{% else %}

sift-package-tcptrace:
  pkg.installed:
    - name: tcptrace

{% endif %}
