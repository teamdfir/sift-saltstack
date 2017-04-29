include:
  - ..repos.sift
  - ..repos.gift
  - .python-dfvfs

python-plaso:
  pkg.installed:
    - name: python-plaso
    - version: 1.4.0-1ppa3~xenial
    - require:
      - pkgrepo: sift
      - pkgrepo: gift
      - pkg: python-dfvfs
