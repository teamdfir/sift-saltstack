include:
  - sift.packages.python3-pip

sift-python3-packages-python-registry:
  pip.installed:
    - name: python-registry
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
