include:
  - sift.packages.python3-pip

sift-python-package-python-dateutil:
  pip.installed:
    - name: python-dateutil >= 2.4.2
    - require:
      - sls: sift.packages.python3-pip
