include:
  - sift.repos.gift

sift-package-libvshadow-tools:
  pkg.installed:
    - name: libvshadow-tools
    - require:
      - sls: sift.repos.gift
