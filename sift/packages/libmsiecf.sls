include:
  - sift.repos.gift

sift-package-libmsiecf:
  pkg.installed:
    - name: libmsiecf
    - require:
      - sls: sift.repos.gift
