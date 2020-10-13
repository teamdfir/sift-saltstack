include:
  - sift.packages.python3-pip

sift-python3-packages-wheel:
  pip.installed:
    - name: wheel
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
