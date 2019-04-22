# Note: not included in init.sls, only required by python-volatility

include:
  - sift.packages.python-pip

simplejson:
  pip.installed:
    - name: simplejson
    - upgrade: True
    - require:
      - sls: sift.packages.python-pip
