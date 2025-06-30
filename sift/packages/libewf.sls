include:
  - sift.repos.gift

sift-package-libewf:
  pkg.installed:
    - name: libewf
    - require:
      - sls: sift.repos.gift
