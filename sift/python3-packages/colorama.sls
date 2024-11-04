include:
  - sift.python3-packages.core

sift-python3-packages-colorama:
  pip.installed:
    - name: colorama
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.core
