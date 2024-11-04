# Note: not included in init.sls, only required by python-volatility

include:
  - sift.packages.python2-pip

sift-python-packages-simplejson:
  pip.installed:
    - name: simplejson
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
