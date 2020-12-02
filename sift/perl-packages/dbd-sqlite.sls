include:
  - sift.packages.perl
  - sift.packages.build-essential

sift-perl-packages-dbd-sqlite:
  cmd.run:
    - name: cpanm --no-man-pages install DBD::SQLite
    - env:
      - PERL_MM_USE_DEFAULT: 1
    - require:
      - sls: sift.packages.perl
      - sls: sift.packages.build-essential
