include:
  - sift.packages.perl

sift-perl-html-quicktable:
  file.managed:
    - name: /usr/share/perl5/QuickTable.pm
    - source: salt://sift/files/perl-modules/QuickTable.pm
    - required:
      - sls: sift.packages.perl

