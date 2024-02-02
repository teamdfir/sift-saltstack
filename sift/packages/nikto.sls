include:
  - sift.repos.ubuntu-multiverse

sift-package-nikto:
  pkg.installed:
    - name: nikto
    - require:
      - sls: sift.repos.ubuntu-multiverse
