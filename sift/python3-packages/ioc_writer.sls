include:
  - sift.packages.python3-pip
  - sift.python3-packages.lxml
  - sift.python3-packages.yara-python

sift-python3-packages-ioc-writer:
  pip.installed:
    - name: ioc_writer
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
      - sls: sift.python3-packages.lxml
      - sls: sift.python3-packages.yara-python
