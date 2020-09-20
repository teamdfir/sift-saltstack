include:
  - sift.packages.python3-pip

sift-python-package-setuptools:
  pip.installed:
    - name: setuptools
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
