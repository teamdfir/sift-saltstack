include:
  - sift.repos.gift

sift-package-libewf-tools:
  pkg.installed:
    - name: libewf-tools
    - require:
      - sls: sift.repos.gift
