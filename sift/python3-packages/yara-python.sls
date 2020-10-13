include:
  - sift.packages.python3-pip

sift-python3-packages-yara-python:
  pip.installed:
    - name: yara-python
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
