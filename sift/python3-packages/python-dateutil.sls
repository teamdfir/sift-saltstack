include:
  - sift.python3-packages.core

sift-python3-packages-python-dateutil:
  pip.installed:
    - name: python-dateutil
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.core
