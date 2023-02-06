include:
  - sift.repos.gift

sift-package-libvmdk:
  pkg.installed:
    - name: libvmdk
    - require:
      - sls: sift.repos.gift
