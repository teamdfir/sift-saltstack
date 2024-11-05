include:
  - sift.packages
  - sift.python-packages

sift-tests-python2-with-apt:
  test.nop:
    - name: sift-tests-python2-with-apt
    - require:
      - sls: sift.packages
      - sls: sift.python-packages

