include:
  - sift.repos.gift

libewf-dev:
  pkg.installed:
    - name: libewf-dev
    - require:
      - sls: sift.repos.gift
