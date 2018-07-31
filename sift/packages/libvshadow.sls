include:
  - sift.repos.gift

sift-package-libvshadow:
  pkg.installed:
    - name: libvshadow
    - require:
      - sls: sift.repos.gift
