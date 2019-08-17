# WEBSITE: https://github.com/HurricaneLabs/machinae
# LICENSE: MIT
include:
  - sift.packages.python-pip
  - sift.packages.python3-pip

sift-python-packages-defang:
  pip.installed:
    - name: defang==0.5.2
    - bin_env: /usr/bin/pip3
    - env_vars:
        LANG: en_US.UTF-8
        LC_ALL: en_US.UTF-8
    - require:
      - sls: sift.packages.python-pip
      - sls: sift.packages.python3-pip
