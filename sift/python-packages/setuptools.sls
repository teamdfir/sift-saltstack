include:
  - sift.packages.python2-pip

sift-python-packages-setuptools:
  pip.installed:
    - name: 'setuptools<66.0.0'
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
