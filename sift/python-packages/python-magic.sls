include:
  - sift.packages.python3-pip

sift-python-package-python-magic:
  pip.installed:
    - name: python-magic
    - require:
      - sls: sift.packages.python3-pip
