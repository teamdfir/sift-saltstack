include:
  - sift.packages.python2-pip
  - sift.packages.python3-pip

openpyxl==2.1.2:
  pip.installed:
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
