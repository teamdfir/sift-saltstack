include:
  - sift.repos
  - sift.packages
  - sift.python3-packages
  - sift.perl-packages
  - sift.scripts

sift-server-include:
  test.nop:
    - name: sift-server-include
    - require:
      - sls: sift.repos
      - sls: sift.packages
      - sls: sift.python3-packages
      - sls: sift.perl-packages
      - sls: sift.scripts
