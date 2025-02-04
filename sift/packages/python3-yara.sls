include:
  - sift.packages.python3

sift-package-python3-yara:
  pkg.installed:
    - name: python3-yara
    - require:
      - sls: sift.packages.python3
