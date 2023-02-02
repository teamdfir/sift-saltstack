include:
  - sift.repos.gift

libfvde-tools:
  pkg.installed:
    - name: libfvde-tools
    - require:
      - sls: sift.repos.gift
