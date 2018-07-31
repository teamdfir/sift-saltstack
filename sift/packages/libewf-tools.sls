include:
  - sift.repos.gift

libewf-tools:
  pkg.installed:
    - name: libewf-tools
    - require:
      - sls: sift.repos.gift
