include:
  - sift.repos.sift
  - sift.repos.gift
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
      - sls: sift.repos.sift
      - sls: sift.repos.gift
      - sls: sift.packages.python3
      - sls: sift.packages.python3-xlsxwriter
      - sls: sift.packages.python3-dfvfs
      - sls: sift.packages.python3-redis
