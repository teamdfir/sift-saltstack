include:
  - sift.packages.python2-pip
  - sift.packages.libxml2-dev
  - sift.packages.libxslt-dev

sift-python-packages-lxml:
  pip.installed:
    - name: lxml
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
      - sls: sift.packages.libxml2-dev
      - sls: sift.packages.libxslt-dev
