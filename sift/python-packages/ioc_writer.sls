include:
  - sift.packages.python3-pip
  - sift.python-packages.lxml

sift-python-package-ioc-writer:
  pip.installed:
    - name: ioc_writer
    - require:
      - sls: sift.packages.python3-pip
      - sls: sift.python-packages.lxml
      
