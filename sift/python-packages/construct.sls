include:
  - sift.packages.python3-pip
  - sift.packages.python2-pip

sift-python-packages-construct:
  pip.installed:
    - name: construct == 2.10.54
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
