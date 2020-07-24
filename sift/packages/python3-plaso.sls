include:
  - sift.repos.sift
  - sift.repos.gift
  - sift.packages.absent.plaso
  - sift.packages.python3
  - sift.packages.python3-xlsxwriter
  - sift.packages.python3-dfvfs

sift-package-python3-plaso:
  pkg.installed:
    - name: python3-plaso
    - version: latest
    - hold: False
    - refresh: True
    - update_holds: True
    - allow_updates: True
    - require:
      - sls: sift.packages.absent.plaso
      - sls: sift.repos.sift
      - sls: sift.repos.gift
      - sls: sift.packages.python3
      - sls: sift.packages.python3-xlsxwriter
      - sls: sift.packages.python3-dfvfs
