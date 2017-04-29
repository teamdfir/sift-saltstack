include:
  - ..packages.python-pip

distorm3:
  pip.installed:
    - require:
      - pkg: python-pip
