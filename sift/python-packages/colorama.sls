include:
  - sift.packages.python3-pip

sift-python-package-colorama:
  pip.installed:
    - name: colorama
    - require:
      - sls: sift.packages.python3-pip
