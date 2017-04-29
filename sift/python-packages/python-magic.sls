include:
  - ..packages.python-pip

python-magic:
  pip.installed:
    - require:
      - pkg: python-pip
