# WEBSITE: https://github.com/HurricaneLabs/machinae
# LICENSE: MIT
include:
  - sift.packages.python3-pip
  - sift.packages.python3-pip
  - sift.python-packages.defang

sift-python-packages-machinae:
  pip.installed:
    - name: machinae
    - bin_env: /usr/bin/pip3
    - env_vars:
        LANG: en_GB.UTF-8
        LC_ALL: en_US.UTF-8
    - require:
      - sls: sift.packages.python3-pip
      - sls: sift.packages.python3-pip
      - sls: sift.python-packages.defang