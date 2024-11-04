include:
  - sift.packages.python2-pip

sift-python-packages-requests:
  pip.installed:
    - name: requests
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
