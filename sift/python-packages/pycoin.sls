# Note: not included in init.sls, only required by python-volatility

include:
  - ..packages.python-pip

pycoin:
  pip.installed:
    - name: pycoin
    - upgrade: True
    - require:
      - pkg: python-pip
