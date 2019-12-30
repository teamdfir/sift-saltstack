include:
  - sift.packages.perl

xpath:
  pkg.installed:
    - name: libxml-xpath-perl
    - require:
      - sls: sift.packages.perl
