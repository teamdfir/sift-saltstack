include:
  - sift.packages.python2-pip

sift-python-packages-python-magic:
  pip.installed:
    - name: python-magic
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
