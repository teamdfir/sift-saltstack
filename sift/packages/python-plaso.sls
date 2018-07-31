include:
  - sift.repos.sift
  - sift.repos.gift
  - sift.packages.absent.plaso
  - sift.packages.python
  - sift.packages.python-xlsxwriter
  - sift.packages.python-dfvfs

python-plaso:
  pkg.installed:
    - name: python-plaso
    - version: latest
    - hold: False
    - refresh: True
    - update_holds: True
    - allow_updates: True
    - require:
      - sls: sift.packages.absent.plaso
      - sls: sift.repos.sift
      - sls: sift.repos.gift
      - sls: sift.packages.python
      - sls: sift.packages.python-xlsxwriter
      - sls: sift.packages.python-dfvfs
