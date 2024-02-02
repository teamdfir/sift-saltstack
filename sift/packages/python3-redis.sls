include:
  - sift.repos.gift

sift-package-python3-redis:
  pkg.installed:
    - name: python3-redis
    - require:
      - sls: sift.repos.gift
