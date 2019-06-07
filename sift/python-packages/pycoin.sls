# Note: not included in init.sls, only required by python-volatility

include:
  - sift.packages.python-pip

pycoin:
  pip.installed:
    - name: pycoin
    - upgrade: True
    - require:
      - sls: sift.packages.python-pip
