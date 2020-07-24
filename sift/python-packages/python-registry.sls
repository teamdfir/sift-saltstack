include:
  - sift.packages.python3-pip

sift-python-package-python-registry:
  pip.installed:
    - name: python-registry
    - require:
      - sls: sift.packages.python3-pip
