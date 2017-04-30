{% if grains['oscodename'] == "trusty" -%}
f-spot:
  pkg.installed
{% else -%}
f-spot:
  test.nop:
    - name: f-spot
{% endif -%}
