include:
  - sift.packages.python3-pip

sift-python3-packages-bitstring:
  pip.installed:
    - name: bitstring
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
