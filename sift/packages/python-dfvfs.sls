include:
  - ..repos.sift
  - ..repos.gift

python-dfvfs:
  pkg.installed:
    - name: python-dfvfs
    - version: 20170406-2ppa1~xenial
    - require:
      - pkgrepo: sift
      - pkgrepo: gift