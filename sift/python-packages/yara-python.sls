# Note: not included in init.sls, only required by python-volatility

include:
  - ..packages.python-pip

yara-python:
  pip.installed:
    - name: yara-python
    - upgrade: True
    - require:
      - pkg: python-pip
