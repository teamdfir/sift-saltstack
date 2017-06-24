include:
  - sift.repos.ubuntu-multiverse

sift-wine:
  pkg.installed:
    - name: wine
    - require:
      - sls: sift.repos.ubuntu-multiverse
