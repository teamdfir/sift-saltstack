include:
  - sift.repos.gift
  - sift.packages.python-plaso

plaso-tools:
  pkg.latest:
    - name: plaso-tools
    - require:
      - sls: sift.repos.gift
      - sls: sift.packages.python-plaso
