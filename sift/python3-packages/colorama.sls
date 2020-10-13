include:
  - sift.packages.python3-pip

sift-python3-packages-colorama:
  pip.installed:
    - name: colorama
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
