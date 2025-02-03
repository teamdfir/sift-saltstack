include:
  - sift.packages.perl

sift-perl-package-libcgi-pm-perl:
  pkg.installed:
    - name: libcgi-pm-perl
    - require:
      - sls: sift.packages.perl
