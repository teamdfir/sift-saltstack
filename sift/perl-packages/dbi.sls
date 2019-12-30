include:
  - sift.packages.perl

dbi:
  pkg.installed:
    - name: libdbi-perl
    - require:
      - sls: sift.packages.perl
