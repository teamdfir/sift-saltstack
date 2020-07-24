include:
  - sift.packages.python3-pip
  - sift.python-packages.lxml

sift-python-package-stix:
  pip.installed:
    - name: stix
    - require:
      - sls: sift.packages.python3-pip
      - sls: sift.python-packages.lxml
