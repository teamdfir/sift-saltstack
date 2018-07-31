include:
  - sift.repos.gift

sift-package-libregf-dev:
  pkg.installed:
    - name: libregf-dev
    - require:
      - sls: sift.repos.gift
