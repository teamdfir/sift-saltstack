# WEBSITE: https://github.com/HurricaneLabs/machinae
# LICENSE: MIT
include:
  - sift.python3-packages.core

sift-python3-packages-defang:
  pip.installed:
    - name: defang
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.core
