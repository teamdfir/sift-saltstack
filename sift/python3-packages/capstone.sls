include:
  - sift.python3-packages.core

sift-python3-package-capstone:
  pip.installed:
    - name: capstone
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.python3-packages.core
