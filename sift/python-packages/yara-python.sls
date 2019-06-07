# Note: not included in init.sls, only required by python-volatility

include:
  - sift.packages.python-pip

yara-python:
  pip.installed:
    - name: yara-python
    - upgrade: True
    - require:
      - sls: sift.packages.python-pip
