include:
  - sift.repos.gift

plaso-data:
  pkg.latest:
    - name: plaso-data
    - require:
      - sls: sift.repos.gift
