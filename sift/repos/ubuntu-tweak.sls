{% if grains['oscodename'] != "xenial" -%}
include:
  - ..packages.python-software-properties

ubuntutweak:
  pkgrepo.managed:
    - ppa: tualatrix/ppa
    - refresh_db: true
{% else -%}
ubuntutweak:
  test.nop:
    - name: ubuntutweak
{% endif -%}
