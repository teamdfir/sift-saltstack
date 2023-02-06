include:
  - sift.packages.python3-pip
  - sift.packages.python2-pip

sift-python-packages-s2sphere:
  pip.installed:
    - name: s2sphere
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
