include:
  - sift.repos.gift

sift-package-libvshadow-python3:
  pkg.installed:
    - name: libvshadow-python3
    - require:
      - sls: sift.repos.gift
