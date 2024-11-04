include:
  - sift.python3-packages.core

sift-python3-packages-ijson:
  pip.installed:
    - name: ijson
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.core
