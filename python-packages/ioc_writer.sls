include:
  - sift.packages.python3-pip
  - sift.packages.python2-pip
  - sift.python-packages.lxml

sift-python-packages-ioc-writer:
  pip.installed:
    - name: ioc_writer
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
      - sls: sift.python-packages.lxml
      
