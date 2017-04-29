include:
  - ..packages.python-pip
  - .lxml

ioc_writer:
  pip.installed:
    - require:
      - pkg: python-pip
      - pip: lxml
      
