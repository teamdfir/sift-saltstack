{% if grains['oscodename'] != "jammy" %}

sift-package-knocker:
  pkg.installed:
    - name: knocker

{% else %}

knocker-not-in-jammy:
  test.nop

{% endif %}
