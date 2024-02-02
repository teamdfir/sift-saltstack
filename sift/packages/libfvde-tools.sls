include:
  - sift.repos.gift

sift-package-libfvde-tools:
  pkg.installed:
    - name: libfvde-tools
    - require:
      - sls: sift.repos.gift
