include:
  - sift.python3-packages.core

analyzemft:
  pip.installed:
    - name: analyzeMFT
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.python3-packages.core
