include:
  - sift.perl-packages.datecalc
  - sift.perl-packages.dbi
  - sift.perl-packages.exiftool
  - sift.perl-packages.json
  - sift.perl-packages.xpath

sift-perl-packages:
  test.nop:
    - name: sift-perl-packages
    - require:
      - sls: sift.perl-packages.datecalc
      - sls: sift.perl-packages.dbi
      - sls: sift.perl-packages.exiftool
      - sls: sift.perl-packages.json
      - sls: sift.perl-packages.xpath
