# Note: not included in init.sls, only required by python-volatility

include:
  - ..packages.python-pip
  - sift.packages.libssl-dev

dpapick:
  pip.installed:
    - name: dpapick
    - upgrade: True
    - require:
      - pkg: python-pip
      - sls: sift.packages.libssl-dev
