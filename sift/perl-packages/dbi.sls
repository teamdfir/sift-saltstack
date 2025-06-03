include:
  - sift.packages.perl

sift-perl-package-libdbi-perl:
  pkg.installed:
    - name: libdbi-perl
    - require:
      - sls: sift.packages.perl
