include:
  - sift.packages.python2-pip
  - sift.python-packages.setuptools

sift-python-packages-argparse:
  pip.installed:
    - name: argparse
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
      - sls: sift.python-packages.setuptools
