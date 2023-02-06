include:
  - sift.packages.perl

exiftool:
  pkg.installed:
    - name: libimage-exiftool-perl
    - require:
      - sls: sift.packages.perl
