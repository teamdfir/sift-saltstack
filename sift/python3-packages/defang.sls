# WEBSITE: https://github.com/HurricaneLabs/machinae
# LICENSE: MIT
include:
  - sift.python3-packages.pip
  - sift.python3-packages.wheel
  - sift.python3-packages.setuptools

sift-python3-packages-defang:
  pip.installed:
    - name: defang==0.5.2
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip
      - sls: sift.python3-packages.wheel
      - sls: sift.python3-packages.setuptools
