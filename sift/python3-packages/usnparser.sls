# Name: USN Journal Parser
# Website: https://github.com/digitalsleuth/USN-Journal-Parser
# Description: Python script to parse the NTFS USN Change Journal
# Category: 
# Author: Adam Witt (PoorBillionaire) / Corey Forman (digitalsleuth)
# License: Apache License v2 (https://github.com/digitalsleuth/USN-Journal-Parser/blob/main/LICENSE)
# Notes: usnparser

include:
  - sift.packages.python3-virtualenv

sift-python3-package-usnparser-venv:
  virtualenv.managed:
    - name: /opt/usnparser
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-usnparser:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/USN-Journal-Parser.git
    - bin_env: /opt/usnparser/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-usnparser-venv

sift-python3-package-usnparser-symlink:
  file.symlink:
    - name: /usr/local/bin/usnparser
    - target: /opt/usnparser/bin/usn.py
    - force: True
    - require:
      - pip: sift-python3-package-usnparser
