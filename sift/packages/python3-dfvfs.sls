include:
  - sift.repos.sift
  - sift.repos.gift

sift-package-python3-dfvfs:
  pkg.installed:
    - name: python3-dfvfs
    - version: latest
    - hold: False
    - refresh: True
    - update_holds: True
    - allow_updates: True
    - require:
      - sls: sift.repos.sift
      - sls: sift.repos.gift
