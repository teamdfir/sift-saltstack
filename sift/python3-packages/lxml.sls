include:
  - sift.packages.python3-pip
  - sift.packages.libxml2-dev
  - sift.packages.libxslt-dev

sift-python3-packages-lxml:
  pip.installed:
    - name: lxml
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
      - sls: sift.packages.libxml2-dev
      - sls: sift.packages.libxslt-dev
