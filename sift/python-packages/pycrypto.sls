# This package is only required for volatility, so it is not included in the init.sls

include:
  - sift.packages.python2-pip

sift-python-packages-pycrypto:
  pip.installed:
    - name: pycrypto
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip

