include:
  - sift.packages.python3-pip

sift-python-package-pysocks:
  pip.installed:
    - name: pysocks
    - require:
      - sls: sift.packages.python3-pip
