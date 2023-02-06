include:
  - sift.repos.ubuntu-multiverse

sift-nikto:
  pkg.installed:
    - name: nikto
    - require:
      - sls: sift.repos.ubuntu-multiverse
