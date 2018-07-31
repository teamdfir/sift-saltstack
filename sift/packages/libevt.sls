include:
  - sift.repos.gift

libevt:
  pkg.installed:
    - name: libevt
    - require:
      - sls: sift.repos.gift
