include:
  - sift.perl-packages.dbi
  - sift.perl-packages.json

sift-perl-packages:
  test.nop:
    - name: sift-perl-packages
    - require:
      - sls: sift.perl-packages.dbi
      - sls: sift.perl-packages.json
