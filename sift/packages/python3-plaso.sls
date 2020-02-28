include:
  - sift.repos.sift
  - sift.repos.gift
  - sift.packages.absent.plaso
  - sift.packages.python
  - sift.packages.python-xlsxwriter
  - sift.packages.python-dfvfs

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
      - sls: sift.packages.python-xlsxwriter
      - sls: sift.packages.python-dfvfs
