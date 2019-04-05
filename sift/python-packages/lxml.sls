include:
  - ..packages.python-pip
  - ..packages.libxml2-dev
  - ..packages.libxslt1-dev

lxml:
  pip.installed:
    - require:
      - pkg: python-pip
      - pkg: libxml2-dev
      - pkg: libxslt1-dev
