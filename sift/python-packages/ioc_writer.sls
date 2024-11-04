include:
  - sift.packages.python2-pip
  - sift.python-packages.lxml
  - sift.python-packages.setuptools

sift-python-packages-ioc-writer:
  pip.installed:
    - name: ioc_writer
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
      - sls: sift.python-packages.lxml
      - sls: sift.python-packages.setuptools
      
