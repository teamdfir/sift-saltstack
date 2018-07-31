include:
  - sift.repos.sift
  - sift.repos.gift
  - sift.packages.absent.plaso

sift-package-python-dfvfs:
  pkg.installed:
    - name: python-dfvfs
    - version: latest
    - hold: False
    - refresh: True
    - update_holds: True
    - allow_updates: True
    - require:
      - sls: sift.packages.absent.plaso
      - sls: sift.repos.sift
      - sls: sift.repos.gift
