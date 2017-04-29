include:
  - ..packages.python-pip

wheel:
  pip.installed:
    - name: wheel
    - upgrade: True
    - require:
      - pkg: python-pip
