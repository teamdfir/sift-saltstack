include:
  - sift.packages.python2-pip

sift-python-packages-usnparser:
  pip.installed:
    - name: usnparser
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
