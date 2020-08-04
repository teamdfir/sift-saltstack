include:
  - sift.repos.ubuntu-universe

sift-package-xmount:
  pkg.latest:
    - name: xmount
    - require:
      - sls: sift.repos.ubuntu-universe
