include:
  - sift.repos.gift

sift-package-libvshadow-python:
  pkg.installed:
    - name: libvshadow-python
    - require:
      - sls: sift.repos.gift
