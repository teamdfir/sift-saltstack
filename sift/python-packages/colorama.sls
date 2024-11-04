include:
  - sift.packages.python2-pip
  - sift.python-packages.setuptools

sift-python-packages-colorama:
  pip.installed:
    - name: colorama
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
      - sls: sift.python-packages.setuptools
