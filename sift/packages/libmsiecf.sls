include:
  - sift.repos.gift

libmsiecf:
  pkg.installed:
    - name: libmsiecf
    - require:
      - sls: sift.repos.gift
