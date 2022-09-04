include:
  - sift.repos.gift
  {% if grains['oscodename'] != "jammy" %}
  - sift.repos.sift
  {% endif %}
  - sift.packages.python3
  - sift.packages.python3-xlsxwriter
  - sift.packages.python3-dfvfs
  - sift.packages.python3-redis

sift-package-python3-plaso:
  pkg.installed:
    - name: python3-plaso
    - version: latest
    - hold: False
    - refresh: True
    - update_holds: True
    - allow_updates: True
    - require:
      - sls: sift.repos.gift
      {% if grains['oscodename'] != "jammy" %}
      - sls: sift.repos.sift
      {% endif %}
      - sls: sift.packages.python3
      - sls: sift.packages.python3-xlsxwriter
      - sls: sift.packages.python3-dfvfs
      - sls: sift.packages.python3-redis
