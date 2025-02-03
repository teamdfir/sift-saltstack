include:
  - sift.packages.perl

sift-perl-package-libxml-xpath-perl:
  pkg.installed:
    - name: libxml-xpath-perl
    - require:
      - sls: sift.packages.perl
