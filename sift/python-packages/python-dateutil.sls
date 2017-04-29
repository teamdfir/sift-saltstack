include:
  - ..packages.python-pip

python-dateutil:
  pip.installed:
    - name: python-dateutil >= 2.4.2
    - require:
      - pkg: python-pip
