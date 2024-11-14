include:
  - sift.packages.python3-pip

sift-python-packages-s2sphere:
  pip.installed:
    - name: s2sphere
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
