include:
  - ..packages.python-pip

pefile:
  pip.installed:
    - require:
      - pkg: python-pip
