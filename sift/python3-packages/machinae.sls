# WEBSITE: https://github.com/HurricaneLabs/machinae
# LICENSE: MIT
include:
  - sift.python3-packages.core
  - sift.python3-packages.defang

sift-python3-packages-machinae:
  pip.installed:
    - name: machinae
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.core
      - sls: sift.python3-packages.defang
