include:
  - sift.packages.python3-pip
  - sift.packages.libxml2-dev
  - sift.packages.libxslt-dev

sift-python-package-lxml:
  pip.installed:
    - name: lxml
    - require:
      - sls: sift.packages.python3-pip
      - sls: sift.packages.libxml2-dev
      - sls: sift.packages.libxslt-dev
