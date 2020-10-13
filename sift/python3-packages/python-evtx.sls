include:
  - sift.packages.python3-pip

sift-python3-packages-python-evtx:
  pip.installed:
    - name: python-evtx
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
