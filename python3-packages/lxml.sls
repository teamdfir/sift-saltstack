include:
  - sift.python3-packages.pip
  - sift.packages.libxml2-dev
  - sift.packages.libxslt-dev

sift-python3-packages-lxml:
  pip.installed:
    - name: lxml
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip
      - sls: sift.packages.libxml2-dev
      - sls: sift.packages.libxslt-dev
