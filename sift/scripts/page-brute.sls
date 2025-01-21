# Name: page-brute
# Website: https://github.com/matonis/page_brute
# Description: Page File analysis tool
# Category: 
# Author: Michael Matonis
# License: Unknown
# Notes: Modified for python3, file stored locally at github.com/teamdfir/sift-saltstack

include:
  - sift.packages.python3-virtualenv

sift-python3-package-page-brute-venv:
  virtualenv.managed:
    - name: /opt/page-brute
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - yara-python
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-page-brute:
  file.recurse:
    - name: /opt/page-brute/bin/
    - source: salt://sift/files/page-brute
    - file_mode: 755
    - require:
      - virtualenv: sift-python3-package-page-brute-venv

sift-python3-package-page-brute-shebang:
  file.replace:
    - name: /opt/page-brute/bin/page_brute-BETA.py
    - pattern: '#!/usr/bin/env python3'
    - repl: '#!/opt/page-brute/bin/python3'
    - count: 1
    - require:
      - file: sift-python3-package-page-brute

sift-python3-package-page-brute-symlink:
  file.symlink:
    - name: /usr/local/bin/page_brute-BETA.py
    - target: /opt/page-brute/bin/page_brute-BETA.py
    - makedirs: False
    - require:
      - file: sift-python3-package-page-brute-shebang
