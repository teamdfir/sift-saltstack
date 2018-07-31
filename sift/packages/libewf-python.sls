include:
  - sift.repos.gift

libewf-python:
  pkg.installed:
    - name: libewf-python
    - require:
      - sls: sift.repos.gift
