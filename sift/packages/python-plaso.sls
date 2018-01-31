include:
  - ..repos.sift
  - ..repos.gift
  - sift.packages.python-xlsxwriter
  - sift.packages.python-dfvfs

python-plaso:
  pkg.installed:
    - name: python-plaso
    - hold: False
    - refresh: True
    - update_holds: True
    - allow_updates: True
    - require:
      - pkgrepo: sift-repo
      - pkgrepo: sift-gift-repo
      - sls: sift.packages.python-xlsxwriter
      - sls: sift.packages.python-dfvfs
