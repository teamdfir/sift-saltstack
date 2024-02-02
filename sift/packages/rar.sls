include:
  - sift.repos.ubuntu-multiverse

sift-package-rar:
  pkg.installed:
    - name: rar
    - require:
      - sls: sift.repos.ubuntu-multiverse
