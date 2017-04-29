include:
  - ..packages.python-pip

setuptools:
  pip.installed:
    - name: setuptools
    - upgrade: True
    - require:
      - pkg: python-pip
