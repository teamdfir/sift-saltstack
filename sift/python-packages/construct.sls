include:
  - ..packages.python-pip

construct:
  pip.installed:
    - require:
      - pkg: python-pip
