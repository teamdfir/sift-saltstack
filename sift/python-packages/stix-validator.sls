include:
  - ..packages.python-pip
  - .stix

stix-validator:
  pip.installed:
    - require:
      - pkg: python-pip
      - pip: stix
