# Note: not included in init.sls, only required by python-volatility

include:
  - sift.packages.python2-pip

sift-python-packages-pycoin:
  pip.installed:
    - name: pycoin
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
