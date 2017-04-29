include:
  - ..packages.python-pip

python-registry:
  pip.installed:
    - require:
      - pkg: python-pip
