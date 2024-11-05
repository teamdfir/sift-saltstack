include:
  - sift.python-packages
  - sift.python3-packages

sift-tests-python:
  test.nop:
    - name: sift-tests-python
    - require:
      - sls: sift.python-packages
      - sls: sift.python3-packages

