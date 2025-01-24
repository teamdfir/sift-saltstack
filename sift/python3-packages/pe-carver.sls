# Name: pe-carver
# Website: https://github.com/digitalsleuth/pe-carver
# Description: Carves EXEs from given data files
# Category: 
# Author: Brian Baskin (Rurik), Corey Forman (digitalsleuth)
# License: Apache License v2 (https://github.com/digitalsleuth/pe-carver/blob/main/LICENSE)
# Notes: pe-carver

include:
  - sift.packages.python3-virtualenv

sift-python3-package-pe-carver-venv:
  virtualenv.managed:
    - name: /opt/pe-carver
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-pe-carver:
  pip.installed:
    - name: pe-carver
    - bin_env: /opt/pe-carver/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-pe-carver-venv

sift-python3-package-pe-carver-symlink:
  file.symlink:
    - name: /usr/local/bin/pe-carver
    - target: /opt/pe-carver/bin/pe-carver
    - makedirs: False
    - require:
      - pip: sift-python3-package-pe-carver
