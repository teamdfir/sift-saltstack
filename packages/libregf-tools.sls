include:
  - sift.repos.gift

sift-package-libregf-tools:
  pkg.installed:
    - name: libregf-tools
    - require:
      - sls: sift.repos.gift
