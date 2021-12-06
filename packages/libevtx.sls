include:
  - sift.repos.gift

libevtx:
  pkg.installed:
    - name: libevtx
    - require:
      - sls: sift.repos.gift
