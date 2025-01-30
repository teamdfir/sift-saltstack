include:
  - sift.packages.perl

sift-perl-package-libjson-perl:
  pkg.installed:
    - name: libjson-perl
    - require:
      - sls: sift.packages.perl
