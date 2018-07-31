include:
  - sift.repos.gift

sift-package-libesedb-tools:
  pkg.installed:
    - name: libesedb-tools
    - require:
      - sls: sift.repos.gift
