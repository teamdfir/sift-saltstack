include:
  - sift.packages.python3-pip

sift-python-package-distorm3:
  pip.installed:
    - name: distorm3
    - require:
      - sls: sift.packages.python3-pip
