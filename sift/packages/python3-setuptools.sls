include:
  - sift.packages.python3

sift-package-python3-setuptools:
  pkg.installed:
    - name: python3-setuptools
    - require:
      - sls: sift.packages.python3
