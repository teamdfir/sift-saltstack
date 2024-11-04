include:
  - sift.python3-packages.core
  - sift.python3-packages.stix

sift-python3-packages-stix-validator:
  pip.installed:
    - name: stix-validator
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.core
      - sls: sift.python3-packages.stix
