# WEBSITE: https://github.com/HurricaneLabs/machinae
# LICENSE: MIT
include:
  - sift.packages.python3-pip

sift-python3-packages-defang:
  pip.installed:
    - name: defang==0.5.2
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.packages.python3-pip
