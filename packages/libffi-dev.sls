include:
  - sift.repos.gift

libffi-dev:
  pkg.installed:
    - name: libffi-dev
    - require:
      - sls: sift.repos.gift
