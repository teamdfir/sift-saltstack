include:
  - sift.repos.gift

libewf-python:
  pkg.installed:
    - name: libewf-python3
    - require:
      - sls: sift.repos.gift
