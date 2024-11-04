# Note: not included in init.sls, only required by python-volatility

include:
  - sift.packages.python2-pip
  - sift.packages.python2-dev
  - sift.packages.build-essential

sift-python-packages-yara-python:
  pip.installed:
    - name: yara-python
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
      - sls: sift.packages.python2-dev
      - sls: sift.packages.build-essential
