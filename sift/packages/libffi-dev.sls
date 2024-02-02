include:
  - sift.repos.gift

sift-package-libffi-dev:
  pkg.installed:
    - name: libffi-dev
    - require:
      - sls: sift.repos.gift
