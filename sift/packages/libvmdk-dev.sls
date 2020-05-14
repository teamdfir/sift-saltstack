include:
  - sift.repos.gift

sift-package-libvmdk-dev:
  pkg.installed:
    - name: libvmdk-dev
    - require:
      - sls: sift.repos.gift
