include:
  - sift.packages.python2-pip
  - sift.python-packages.setuptools

sift-python-packages-docopt:
  pip.installed:
    - name: docopt
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
      - sls: sift.python-packages.setuptools
