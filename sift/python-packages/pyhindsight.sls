include:
  - ..packages.python-pip
  
sift-pyhindsight:
  pip.installed:
    - name: pyhindsight
    - require:
      - pkg: python-pip
