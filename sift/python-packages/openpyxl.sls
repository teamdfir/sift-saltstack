include:
  - sift.packages.python2-pip

openpyxl==2.1.2:
  pip.installed:
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
