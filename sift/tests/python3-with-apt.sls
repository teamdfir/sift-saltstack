include:
  - sift.packages
  - sift.python3-packages

sift-tests-python3-with-apt:
  test.nop:
    - name: sift-tests-python3-with-apt
    - require:
      - sls: sift.packages
      - sls: sift.python3-packages

