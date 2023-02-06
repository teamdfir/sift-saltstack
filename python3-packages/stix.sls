include:
  - sift.python3-packages.pip
  - sift.python3-packages.lxml

sift-python3-packages-stix:
  pip.installed:
    - name: stix
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip
      - sls: sift.python3-packages.lxml
