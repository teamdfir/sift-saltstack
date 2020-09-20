include:
  - sift.packages.python3-pip
  - sift.python-packages.stix

sift-python-package-stix-validator:
  pip.installed:
    - name: stix-validator
    - require:
      - sls: sift.packages.python3-pip
      - sls: sift.python-packages.stix
