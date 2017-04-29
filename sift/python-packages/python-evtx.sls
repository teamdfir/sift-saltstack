include:
  - ..packages.python-pip

python-evtx:
  pip.installed:
    - require:
      - pkg: python-pip
