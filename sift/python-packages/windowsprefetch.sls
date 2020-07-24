include:
  - sift.packages.python3-pip

sift-python-package-windowsprefetch:
  pip.installed:
    - name: windowsprefetch
    - require:
      - sls: sift.packages.python3-pip
