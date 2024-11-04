include:
  - sift.packages.python2-pip

sift-python-packages-unicodecsv:
  pip.installed:
    - name: unicodecsv
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
