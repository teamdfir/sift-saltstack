include:
  - sift.packages.python3-pip
  - sift.packages.python2-pip

sift-python-packages-poster:
  pip.installed:
    - name: poster
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
