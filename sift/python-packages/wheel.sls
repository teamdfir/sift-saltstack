include:
  - sift.packages.python3-pip

sift-python-package-wheel:
  pip.installed:
    - name: wheel
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
