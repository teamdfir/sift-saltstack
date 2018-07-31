include:
  - sift.repos.gift

libevt-tools:
  pkg.installed:
    - name: libevt-tools
    - require:
      - sls: sift.repos.gift
