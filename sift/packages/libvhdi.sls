include:
  - sift.repos.gift

sift-package-libvhdi:
  pkg.installed:
    - name: libvhdi
    - require:
      - sls: sift.repos.gift
