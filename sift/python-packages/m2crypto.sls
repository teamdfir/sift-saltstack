include:
  - sift.packages.python-pip
  - sift.packages.swig

sift-python-packages-m2crypto:
  pip.installed:
    - name: m2crypto
    - require:
      - sls: sift.packages.python-pip
      - sls: sift.packages.swig
