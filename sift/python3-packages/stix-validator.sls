include:
  - sift.python3-packages.pip
  - sift.python3-packages.stix

sift-python3-packages-stix-validator:
  pip.installed:
    - name: stix-validator
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip
      - sls: sift.python3-packages.stix
