include:
  - sift.repos.gift

sift-package-libolecf:
  pkg.installed:
    - name: libolecf
    - require:
      - sls: sift.repos.gift
