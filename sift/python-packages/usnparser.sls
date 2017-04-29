include:
  - ..packages.python-pip

usnparser:
  pip.installed:
    - require:
      - pkg: python-pip
