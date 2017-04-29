include:
  - ..packages.python-pip
  
pip:
  pip.installed:
    - name: pip
    - upgrade: True
    - require:
      - pkg: python-pip
