include:
  - sift.repos.gift

libfvde:
  pkg.installed:
    - require:
      - sls: sift.repos.gift
