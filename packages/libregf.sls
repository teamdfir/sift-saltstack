include:
  - sift.repos.gift

sift-package-libregf:
  pkg.installed:
    - name: libregf
    - require:
      - sls: sift.repos.gift
