# Note: not included in init.sls, only required by volatility

include:
  - sift.packages.libssl-dev
  - sift.packages.python2-pip
  - sift.python-packages.m2crypto

dpapick:
  pip.installed:
    - name: dpapick
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.libssl-dev
      - sls: sift.packages.python2-pip
      - sls: sift.python-packages.m2crypto
