include:
  - sift.python3-packages.pip

sift-python3-packages-python-evtx:
  pip.installed:
    - name: python-evtx
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip
