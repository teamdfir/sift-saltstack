include:
  - sift.packages
  - sift.python-packages
  - sift.python3-packages
  - sift.scripts

sift-tests-python-with-apt-scripts:
  test.nop:
    - name: sift-tests-python-with-apt-scripts
    - require:
      - sls: sift.packages
      - sls: sift.python-packages
      - sls: sift.python3-packages
      - sls: sift.scripts

