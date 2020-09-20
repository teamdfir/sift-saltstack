include:
  - sift.packages.python3-pip

sift-python-package-construct:
  pip.installed:
    - name: construct
    - require:
      - sls: sift.packages.python3-pip
