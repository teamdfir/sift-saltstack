include:
  - sift.packages.python3-pip

sift-python-package-docopt:
  pip.installed:
    - name: docopt
    - require:
      - sls: sift.packages.python3-pip
