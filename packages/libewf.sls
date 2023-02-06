include:
  - sift.repos.gift

libewf:
  pkg.installed:
    - name: libewf
    - require:
      - sls: sift.repos.gift
