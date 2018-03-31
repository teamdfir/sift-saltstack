# WEBSITE: https://github.com/HurricaneLabs/machinae
# LICENSE: MIT
include:
  - sift.packages.python-pip
  - sift.packages.python3-pip

sift-python-packages-machinae:
  pip.installed:
    - name: machinae
    - bin_env: /usr/bin/pip3
    - require:
      - sls: sift.packages.python-pip
      - sls: sift.packages.python3-pip
