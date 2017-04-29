include:
  - ..packages.python-pip
  - .lxml

stix:
  pip.installed:
    - require:
      - pkg: python-pip
      - pip: lxml
