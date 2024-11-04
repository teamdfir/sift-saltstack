include:
  - sift.python3-packages.core
  - sift.python3-packages.lxml

sift-python3-packages-stix:
  pip.installed:
    - name: stix
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.core
      - sls: sift.python3-packages.lxml
