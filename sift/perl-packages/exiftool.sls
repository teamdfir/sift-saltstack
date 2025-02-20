include:
  - sift.packages.perl

sift-perl-package-libimage-exiftool-perl:
  pkg.installed:
    - name: libimage-exiftool-perl
    - require:
      - sls: sift.packages.perl
