include:
  - sift.packages.python3-pip
  - sift.python3-packages.lxml

sift-python3-packages-stix:
  pip.installed:
    - name: stix
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
      - sls: sift.python3-packages.lxml
