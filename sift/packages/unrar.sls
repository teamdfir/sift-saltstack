include:
  - sift.repos.ubuntu-multiverse

sift-package-unrar:
  pkg.installed:
    - name: unrar
    - require:
      - sls: sift.repos.ubuntu-multiverse
