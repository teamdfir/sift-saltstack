include:
  - sift.packages.perl
  - sift.packages.build-essential

sift-perl-packages-quicktable:
  cmd.run:
    - name: cpan install HTML::QuickTable
    - require:
      - sls: sift.packages.perl
      - sls: sift.packages.build-essential
