include:
  - sift.packages.python3-pip
  - sift.python3-packages.stix

sift-python3-packages-stix-validator:
  pip.installed:
    - name: stix-validator
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
      - sls: sift.python3-packages.stix
