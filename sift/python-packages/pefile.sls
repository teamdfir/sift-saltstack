include:
  - sift.packages.python2-pip

sift-python-packages-pefile:
  pip.installed:
    - name: pefile
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
