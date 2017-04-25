include:
  - ..repos.sift
  - .python-dfvfs

python-plaso:
  pkg.installed:
    - name: python-plaso
    - version: 1.5.1-1ppa1~xenial
    - require:
      - pkgrepo: gift
      - pkg: python-dfvfs
