include:
  - sift.packages.python3-pip

sift-python-package-pefile:
  pip.installed:
    - name: pefile
    - require:
      - sls: sift.packages.python3-pip
