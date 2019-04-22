include:
  - sift.repos.sift
  - sift.repos.gift
  {% if grains['oscodename'] == "xenial" -%}
  - sift.packages.absent.plaso
  {% endif %}

sift-package-python-dfvfs:
  pkg.installed:
    - name: python-dfvfs
    - version: latest
    - hold: False
    - refresh: True
    - update_holds: True
    - allow_updates: True
    - require:
      {% if grains['oscodename'] == "xenial" -%}
      - sls: sift.packages.absent.plaso
      {% endif -%}
      - sls: sift.repos.sift
      - sls: sift.repos.gift
