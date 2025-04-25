include:
  - sift.repos.ubuntu-universe

sift-unrar:
  pkg.installed:
    - name: unrar-free
    - require:
      - sls: sift.repos.ubuntu-universe
