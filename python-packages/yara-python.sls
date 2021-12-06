# Note: not included in init.sls, only required by python-volatility

include:
  - sift.packages.python3-pip
  - sift.packages.python2-pip

sift-python-packages-yara-python:
  pip.installed:
    - name: yara-python
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
