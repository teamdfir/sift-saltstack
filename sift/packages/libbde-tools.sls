include:
  - sift.repos.gift

sift-package-libbde-tools:
  pkg.installed:
    - name: libbde-tools
    - require:
      - sls: sift.repos.gift
