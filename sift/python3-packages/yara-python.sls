include:
  - sift.python3-packages.core

sift-python3-packages-yara-python:
  pip.installed:
    - name: yara-python
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.core
