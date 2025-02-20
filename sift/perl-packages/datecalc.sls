include:
  - sift.packages.perl

sift-perl-package-libdate-calc-perl:
  pkg.installed:
    - name: libdate-calc-perl
    - require:
      - sls: sift.packages.perl
