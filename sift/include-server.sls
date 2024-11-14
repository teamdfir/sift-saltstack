include:
  - sift.repos
  - sift.python3-packages
  - sift.python-packages
  - sift.packages
  - sift.perl-packages
  - sift.scripts

sift-server-include:
  test.nop:
    - name: sift-server-include
    - require:
      - sls: sift.repos
      - sls: sift.python3-packages
      - sls: sift.python-packages
      - sls: sift.packages
      - sls: sift.perl-packages
      - sls: sift.scripts
