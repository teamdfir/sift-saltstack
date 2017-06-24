include:
  - sift.repos.ubuntu-multiverse

sift-rar:
  pkg.installed:
    - name: rar
    - require:
      - sls: sift.repos.ubuntu-multiverse
