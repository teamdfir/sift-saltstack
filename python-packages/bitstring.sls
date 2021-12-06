include:
  - sift.packages.python3-pip
  - sift.packages.python2-pip

sift-python-packages-bitstring:
  pip.installed:
    - name: bitstring
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
