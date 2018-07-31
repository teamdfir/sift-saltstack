include:
  - sift.repos.sift

bitpim:
  pkg.installed:
    - name: bitpim
    - require:
      - sls: sift.repos.sift
