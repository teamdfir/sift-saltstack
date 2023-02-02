include:
  - sift.repos.gift

libevtx-tools:
  pkg.installed:
    - name: libevtx-tools
    - require:
      - sls: sift.repos.gift
