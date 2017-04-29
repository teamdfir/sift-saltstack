include:
  - ..packages.python-pip

analyzemft:
  pip.installed:
    - require:
      - pkg: python-pip
