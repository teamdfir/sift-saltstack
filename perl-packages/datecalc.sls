include:
  - sift.packages.perl

datecalc:
  pkg.installed:
    - name: libdate-calc-perl
    - require:
      - sls: sift.packages.perl
