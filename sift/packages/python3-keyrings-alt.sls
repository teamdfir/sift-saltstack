include:
  - sift.packages.python3

sift-package-python3-keyrings-alt:
  pkg.installed:
    - name: python3-keyrings.alt
    - require:
      - sls: sift.packages.python3
