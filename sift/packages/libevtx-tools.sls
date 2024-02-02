include:
  - sift.repos.gift

sift-package-libevtx-tools:
  pkg.installed:
    - name: libevtx-tools
    - require:
      - sls: sift.repos.gift
