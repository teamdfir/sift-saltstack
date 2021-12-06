include:
  - sift.repos.gift

sift-package-libregf-python:
  pkg.installed:
    - name: libregf-python
    - require:
      - sls: sift.repos.gift
