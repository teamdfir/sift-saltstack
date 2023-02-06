include:
  - sift.repos.gift

sift-package-libfsapfs-tools:
  pkg.installed:
    - name: libfsapfs-tools
    - require:
      - sls: sift.repos.gift


