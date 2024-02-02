include:
  - sift.repos.gift
  - sift.packages.python3-plaso

sift-package-plaso-tools:
  pkg.latest:
    - name: plaso-tools
    - require:
      - sls: sift.repos.gift
      - sls: sift.packages.python3-plaso
