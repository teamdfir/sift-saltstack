include:
  - sift.repos.gift

sift-package-libewf-python3:
  pkg.installed:
    - name: libewf-python3
    - require:
      - sls: sift.repos.gift
