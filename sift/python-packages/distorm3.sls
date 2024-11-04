include:
  - sift.packages.python2-pip
  - sift.packages.python2-dev
  - sift.packages.build-essential
  - sift.python-packages.setuptools

sift-python-packages-distorm3:
  pip.installed:
    - name: distorm3 == 3.4.4
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
      - sls: sift.packages.python2-dev
      - sls: sift.packages.build-essential
      - sls: sift.python-packages.setuptools
