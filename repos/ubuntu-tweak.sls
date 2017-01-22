{%- if grains['oscodename'] != "xenial" -%}
ubuntutweak:
  pkgrepo.managed:
    - ppa: tualatrix/ppa
    - refresh_db: true
{%- endif -%}
