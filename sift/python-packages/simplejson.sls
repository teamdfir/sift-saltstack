# Note: not included in init.sls, only required by python-volatility

include:
  - ..packages.python-pip

simplejson:
  pip.installed:
    - name: simplejson
    - upgrade: True
    - require:
      - pkg: python-pip
