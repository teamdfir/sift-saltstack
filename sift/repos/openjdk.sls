include:
  - sift.packages.python-software-properties

openjdk-repo:
  pkgrepo.managed:
    - ppa: openjdk-r/ppa
    - refresh_db: true
    - require:
      - pkg: python-software-properties
