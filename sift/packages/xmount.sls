include:
  - sift.repos.ubuntu-universe

sift-packages-xmount:
  pkg.latest:
    - name: xmount
    - require:
      - sls: sift.repos.ubuntu-universe
