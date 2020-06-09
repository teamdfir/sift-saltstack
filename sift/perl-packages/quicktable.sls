include:
  - sift.packages.perl
  - sift.packages.build-essential

sift-perl-packages-quicktable:
  cmd.run:
    - name: cpan install HTML::QuickTable
    - env:
      - PERL_MM_USE_DEFAULT: 1
    - require:
      - sls: sift.packages.perl
      - sls: sift.packages.build-essential
