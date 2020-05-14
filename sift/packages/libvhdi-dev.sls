include:
  - sift.repos.gift

sift-package-libvhdi-dev:
  pkg.installed:
    - name: libvhdi-dev
    - require:
      - sls: sift.repos.gift
