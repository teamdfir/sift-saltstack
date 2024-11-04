include:
  - sift.packages.python2-pip
  - sift.python-packages.setuptools

sift-python-packages-construct:
  pip.installed:
    - name: construct == 2.10.54 # note: pinned due to volatility2
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
      - sls: sift.python-packages.setuptools
