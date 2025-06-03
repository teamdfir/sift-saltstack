include:
  - sift.packages.python3

sift-package-python3-setuptools-rust:
  pkg.installed:
    - name: python3-setuptools-rust
    - require:
      - sls: sift.packages.python3
