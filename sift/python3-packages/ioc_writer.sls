include:
  - sift.python3-packages.pip
  - sift.python3-packages.setuptools
  - sift.python3-packages.lxml
  - sift.python3-packages.yara-python

sift-python3-packages-ioc-writer:
  pip.installed:
    - name: ioc_writer
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip
      - sls: sift.python3-packages.setuptools
      - sls: sift.python3-packages.lxml
      - sls: sift.python3-packages.yara-python
