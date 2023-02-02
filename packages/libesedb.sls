include:
  - sift.repos.gift

sift-package-libesedb:
  pkg.installed:
    - name: libesedb
    - require:
      - sls: sift.repos.gift
