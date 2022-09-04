{% if grains['oscodename'] != "jammy" %}

knocker:
  pkg.installed

{% else %}

knocker-not-in-jammy:
  test.nop

{% endif %}
