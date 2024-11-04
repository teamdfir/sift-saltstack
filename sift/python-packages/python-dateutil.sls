include:
  - sift.packages.python2-pip

sift-python-packages-python-dateutil:
  pip.installed:
    - name: 'python-dateutil>=2.4.2'
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
