include:
  - sift.repos.gift
  - sift.packages.plaso-data
  - sift.packages.python-plaso

plaso-tools:
  pkg.latest:
    - name: plaso-tools
    - require:
      - sls: sift.repos.gift
      - sls: sift.packages.plaso-data
      - sls: sift.packages.python-plaso
