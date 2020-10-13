include:
  - sift.packages.python3-pip
  - sift.packages.python2-pip

sift-python-packages-setuptools:
  pip.installed:
    - name: setuptools
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
