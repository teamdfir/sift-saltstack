include:
  - sift.repos.sift

xmount:
  pkg.latest:
    - name: xmount
    - require:
      - sls: sift.repos.gift
