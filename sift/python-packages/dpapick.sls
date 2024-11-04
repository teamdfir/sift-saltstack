# Note: not included in init.sls, only required by volatility

include:
  - sift.packages.libssl-dev
  - sift.packages.python2-pip
  - sift.python-packages.m2crypto

dpapick:
  pip.installed:
    - name: dpapick
    - upgrade: True
    - bin_env: /usr/bin/python2
    #- install_options: --upgrade-strategy=only-if-needed
    - require:
      - sls: sift.packages.libssl-dev
      - sls: sift.packages.python2-pip
      - sls: sift.python-packages.m2crypto
