include:
  - sift.packages
  - sift.python-packages
  - sift.python3-packages

sift-tests-python-with-apt:
  test.nop:
    - name: sift-tests-python-with-apt
    - require:
      - sls: sift.packages
      - sls: sift.python-packages
      - sls: sift.python3-packages

