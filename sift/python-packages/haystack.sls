# Note: not included in init.sls, only required by python-volatility

include:
  - ..packages.python-pip

haystack:
  pip.installed:
    - name: haystack
    - upgrade: True
    - require:
      - pkg: python-pip
