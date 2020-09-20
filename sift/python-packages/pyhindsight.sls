include:
  - ..packages.python3-pip
  
sift-pyhindsight:
  pip.installed:
    - name: pyhindsight
    - require:
      - pkg: python-pip
