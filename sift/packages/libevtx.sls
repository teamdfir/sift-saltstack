include:
  - sift.repos.gift

sift-package-libevtx:
  pkg.installed:
    - name: libevtx
    - require:
      - sls: sift.repos.gift
