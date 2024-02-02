include:
  - sift.repos.gift

sift-package-plaso-data:
  pkg.latest:
    - name: plaso-data
    - require:
      - sls: sift.repos.gift
