include:
  - sift.packages.python3-pip
  - sift.packages.python2-pip

sift-python-packages-six:
  pip.installed:
    - name: six
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
