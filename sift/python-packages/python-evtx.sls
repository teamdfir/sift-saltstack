include:
  - sift.packages.python3-pip

sift-python-package-python-evtx:
  pip.installed:
    - name: python-evtx
    - require:
      - sls: sift.packages.python3-pip
