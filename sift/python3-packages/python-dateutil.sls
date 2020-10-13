include:
  - sift.packages.python3-pip

sift-python3-packages-python-dateutil:
  pip.installed:
    - name: python-dateutil
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
