include:
  - sift.packages.python2-pip

sift-python-packages-six:
  pip.installed:
    - name: six
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
