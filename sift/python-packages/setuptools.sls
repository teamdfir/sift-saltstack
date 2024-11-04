include:
  - sift.packages.python2-pip

sift-python-packages-setuptools:
  pip.installed:
    - name: setuptools
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
