include:
  - sift.repos.sift

sift-package-libpff-python:
  pkg.installed:
    - name: libpff-python
    - require:
      - sls: sift.repos.sift
