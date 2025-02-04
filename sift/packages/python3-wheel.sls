include:
  - sift.packages.python3

sift-package-python3-wheel:
  pkg.installed:
    - name: python3-wheel
    - require:
      - sls: sift.packages.python3
