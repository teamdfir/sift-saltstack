# Name: xLEAPP
# Website: https://github.com/flamusdiu/xleapp
# Description: Merging of iLEAPP/RLEAPP/vLEAPP/ALEAPP/cLEAPP
# Category: Mobile
# Author: Jesse Spangenberger
# License: MIT License (https://github.com/flamusdiu/xleapp/blob/main/LICENSE)
# Notes: 

include:
  - sift.packages.python3-virtualenv

sift-python3-package-xleapp-virtualenv:
  virtualenv.managed:
    - name: /opt/xleapp
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - PySimpleGUI>=4.60.4,<6.0.0
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-xleapp:
  pip.installed:
    - name: xleapp
    - bin_env: /opt/xleapp/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-xleapp-virtualenv

