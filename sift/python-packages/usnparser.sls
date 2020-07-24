include:
  - sift.packages.python3-pip

sift-python-package-usnparser:
  pip.installed:
    - name: usnparser
    - require:
      - sls: sift.packages.python3-pip
