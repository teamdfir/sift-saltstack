include:
  - sift.packages.git
  - sift.packages.python3-pip

sift-python-ntdsxtract:
  pip.installed:
    - name: git+https://github.com/csababarta/ntdsxtract.git@7fa1c8c28cbbf97a42bef40f20009dba85e4c25f
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python3-pip
