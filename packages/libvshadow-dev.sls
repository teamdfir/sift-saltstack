include:
  - sift.repos.gift

sift-package-libvshadow-dev:
  pkg.installed:
    - name: libvshadow-dev
    - require:
      - sls: sift.repos.gift
