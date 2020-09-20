# Note: not included in init.sls, only required by volatility

include:
  - sift.packages.libssl-dev
  - sift.packages.python3-pip
  - sift.packages.python3-m2crypto
  - sift.python-packages.m2crypto

dpapick:
  pip.installed:
    - name: dpapick
    - upgrade: True
    #- install_options: --upgrade-strategy=only-if-needed
    - require:
      - sls: sift.packages.libssl-dev
      - sls: sift.packages.python3-pip
      - sls: sift.packages.python3-m2crypto
      - sls: sift.python-packages.m2crypto
