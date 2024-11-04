include:
  - sift.packages.git
  - sift.packages.python2-pip

sift-python-ntdsxtract:
  pip.installed:
    - name: git+https://github.com/csababarta/ntdsxtract.git@7fa1c8c28cbbf97a42bef40f20009dba85e4c25f
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python2-pip
