include:
  - sift.repos.gift

sift-package-libevt-tools:
  pkg.installed:
    - name: libevt-tools
    - require:
      - sls: sift.repos.gift
