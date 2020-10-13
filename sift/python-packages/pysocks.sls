include:
  - sift.packages.python3-pip
  - sift.packages.python2-pip

sift-python-packages-pysocks:
  pip.installed:
    - name: pysocks
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
