include:
  - sift.python3-packages
  - sift.python-packages
  - sift.packages

sift-tests-python-with-apt:
  test.nop:
    - name: sift-tests-python-with-apt
    - require:
      - sls: sift.python3-packages
      - sls: sift.python-packages
      - sls: sift.packages

