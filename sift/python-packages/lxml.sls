include:
  - ..packages.python-pip
  - ..packages.libxml2-dev
  - ..packages.libxslt-dev

lxml:
  pip.installed:
    - require:
      - pkg: python-pip
      - pkg: libxml2-dev
      - pkg: libxslt-dev
