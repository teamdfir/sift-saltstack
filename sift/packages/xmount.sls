include:
  - sift.repos.sift

sift-package-xmount:
  pkg.latest:
    - name: xmount
    - require:
      - sls: sift.repos.sift
