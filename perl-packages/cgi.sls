include:
  - sift.packages.perl

cgi:
  pkg.installed:
    - name: libcgi-pm-perl
    - require:
      - sls: sift.packages.perl
