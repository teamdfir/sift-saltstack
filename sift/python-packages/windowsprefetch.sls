include:
  - ..packages.python-pip

windowsprefetch:
  pip.installed:
    - require:
      - pkg: python-pip
