include:
  - ..packages.python-pip

six:
  pip.installed:
    - require:
      - pkg: python-pip
