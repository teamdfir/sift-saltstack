include:
  - sift.repos.gift

libesedb:
  pkg.installed:
    - name: libesedb
    - require:
      - sls: sift.repos.gift
