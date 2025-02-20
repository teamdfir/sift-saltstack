include:
  - sift.python-packages.setuptools
  - sift.python-packages.wheel
  - sift.python-packages.volatility

sift-python-packages:
  test.nop:
    - name: sift-python-packages
    - require:
      - sls: sift.python-packages.setuptools
      - sls: sift.python-packages.wheel
      - sls: sift.python-packages.volatility
