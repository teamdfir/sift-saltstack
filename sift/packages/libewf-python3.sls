include:
  - sift.repos.gift

sift-package-libewf-python:
  pkg.installed:
    - name: libewf-python3
    - require:
      - sls: sift.repos.gift
