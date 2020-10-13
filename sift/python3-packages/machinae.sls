# WEBSITE: https://github.com/HurricaneLabs/machinae
# LICENSE: MIT
include:
  - sift.packages.python3-pip
  - sift.python3-packages.defang

sift-python3-packages-machinae:
  pip.installed:
    - name: machinae
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.packages.python3-pip
      - sls: sift.python3-packages.defang
