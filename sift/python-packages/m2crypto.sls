include:
  - sift.packages.python3-pip
  - sift.packages.swig

sift-python-packages-m2crypto:
  pip.installed:
    - name: m2crypto
    - require:
      - sls: sift.packages.python3-pip
      - sls: sift.packages.swig
