include:
  - sift.repos
  - sift.python-packages
  - sift.python3-packages
  - sift.packages
  - sift.perl-packages
  - sift.scripts

sift-server-include:
  test.nop:
    - name: sift-server-include
    - require:
      - sls: sift.repos
      - sls: sift.python-packages
      - sls: sift.python3-packages
      - sls: sift.packages
      - sls: sift.perl-packages
      - sls: sift.scripts
