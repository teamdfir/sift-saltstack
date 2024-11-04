include:
  - sift.python3-packages.core
  - sift.python3-packages.lxml
  - sift.python3-packages.yara-python

sift-python3-packages-ioc-writer:
  pip.installed:
    - name: ioc_writer
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.core
      - sls: sift.python3-packages.lxml
      - sls: sift.python3-packages.yara-python
