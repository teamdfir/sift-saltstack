include:
  - sift.packages.perl

json:
  pkg.installed:
    - name: libjson-perl
    - require:
      - sls: sift.packages.perl
