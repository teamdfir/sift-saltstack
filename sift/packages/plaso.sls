include:
  - sift.repos.gift
  - sift.packages.python3-plaso
  - sift.packages.plaso-tools
  - sift.packages.plaso-data

sift-package-plaso:
  test.nop:
    - name: sift-package-plaso
    - require:
      - sls: sift.repos.gift
      - sls: sift.packages.python3-plaso
      - sls: sift.packages.plaso-tools
      - sls: sift.packages.plaso-data
