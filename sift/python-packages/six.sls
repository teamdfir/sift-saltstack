include:
  - sift.packages.python3-pip

sift-python-package-six:
  pip.installed:
    - name: six
    - require:
      - sls: sift.packages.python3-pip
