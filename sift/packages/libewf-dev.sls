include:
  - sift.repos.gift

sift-package-libewf-dev:
  pkg.installed:
    - name: libewf-dev
    - require:
      - sls: sift.repos.gift
