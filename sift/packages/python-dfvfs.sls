include:
  - ..repos.sift
  - ..repos.gift

python-dfvfs:
  pkg.installed:
    - name: python-dfvfs
    - version: 20160108-1ppa1~xenial
    - hold: True
    - require:
      - pkgrepo: sift
      - pkgrepo: gift
