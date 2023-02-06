include:
  - sift.repos.gift

python3-redis:
  pkg.installed:
    - require:
      - sls: sift.repos.gift
