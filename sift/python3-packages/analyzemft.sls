include:
  - sift.packages.python3-pip

analyzemft:
  pip.installed:
    - name: analyzeMFT
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
