include:
  - sift.repos.gift

sift-package-libregf-python3:
  pkg.installed:
    - name: libregf-python3
    - require:
      - sls: sift.repos.gift
