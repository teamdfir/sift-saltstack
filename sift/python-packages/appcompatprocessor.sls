include:
  - sift.packages.git
  - sift.packages.python-pip

appcompatprocessor:
  pip.installed:
    - name: git+https://github.com/mbevilacqua/appcompatprocessor.git
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python-pip
