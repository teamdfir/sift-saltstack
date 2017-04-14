include:
  - ..repos.sift
  - .python-dfvfs

python-plaso:
  pkg.installed:
    - name: python-plaso
    - version: 1.4.0-1ppa3~xenial
    - require:
      - pkgrepo: sift
      - pkg: python-dfvfs
