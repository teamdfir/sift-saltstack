include:
  - sift.packages.python3-pip

sift-python-package-unicodecsv:
  pip.installed:
    - name: unicodecsv
    - require:
      - sls: sift.packages.python3-pip
