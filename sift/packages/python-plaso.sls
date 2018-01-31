include:
  - ..repos.sift
  - ..repos.gift
  - sift.packages.python-xlsxwriter
  - sift.packages.python-dfvfs

python-plaso:
  pkg.installed:
    - name: python-plaso
    #- version: 1.4.0-1ppa3~xenial
    #- hold: True
    - require:
      - pkgrepo: sift-repo
      - pkgrepo: sift-gift-repo
      - sls: sift.packages.python-xlsxwriter
      - sls: sift.packages.python-dfvfs
