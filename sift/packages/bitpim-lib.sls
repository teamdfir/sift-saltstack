include:
  - sift.repos.sift

bitpim-lib:
  pkg.installed:
    - name: bitpim-lib
    - require:
      - sls: sift.repos.sift
