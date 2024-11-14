include:
  - sift.python3-packages.core

sift-python3-package-windowsprefetch:
  pip.installed:
    - name: windowsprefetch
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.python3-packages.core
