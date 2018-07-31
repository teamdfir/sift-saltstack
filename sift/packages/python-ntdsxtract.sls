include:
  - sift.repos.gift
  - sift.repos.sift
  - sift.packages.libesedb

sift-package-python-ntdsxtract:
  pkg.installed:
    - name: python-ntdsxtract
    - require:
      - sls: sift.repos.gift
      - sls: sift.repos.sift
      - sls: sift.packages.libesedb
