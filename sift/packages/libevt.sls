include:
  - sift.repos.gift

sift-package-libevt:
  pkg.installed:
    - name: libevt
    - require:
      - sls: sift.repos.gift
