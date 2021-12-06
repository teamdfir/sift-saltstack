include:
  - sift.repos.ubuntu-multiverse

sift-unrar:
  pkg.installed:
    - name: unrar
    - require:
      - sls: sift.repos.ubuntu-multiverse
