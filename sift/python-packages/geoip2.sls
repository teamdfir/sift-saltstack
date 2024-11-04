include:
  - sift.packages.python2-pip
  - sift.python-packages.setuptools

sift-python-packages-geoip2:
  pip.installed:
    - name: geoip2
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
      - sls: sift.python-packages.setuptools
