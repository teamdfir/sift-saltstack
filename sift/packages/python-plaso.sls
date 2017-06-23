include:
  - ..repos.sift
  - ..repos.gift
  - .python-dfvfs

python-plaso:
  pkg.installed:
    - name: python-plaso
    - version: 1.4.0-1ppa3~xenial
    - hold: True
    - require:
      - pkgrepo: sift-repo
      - pkgrepo: sift-gift-repo
      - pkg: python-dfvfs
