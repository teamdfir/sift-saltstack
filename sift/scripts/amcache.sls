# Name: amcache
# Website: https://github.com/williballenthin/python-registry
# Description: Python script to parse amcache artifacts from the Amcache.hve registry file
# Category:
# Author: Willi Ballenthin
# License: Apache License v2 (https://github.com/williballenthin/python-registry/blob/master/LICENSE.TXT)
# Notes: amcache.py

include:
  - sift.packages.python3-virtualenv

sift-python3-package-amcache-venv:
  virtualenv.managed:
    - name: /opt/amcache
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - python-registry
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-amcache:
  file.recurse:
    - name: /opt/amcache/bin/
    - source: salt://sift/files/amcache
    - file_mode: 755

sift-python3-package-amcache-shebang:
  file.replace:
    - name: /opt/amcache/bin/amcache.py
    - pattern: '#!/usr/bin/env python3'
    - repl: '#!/opt/amcache/bin/python3'
    - count: 1
    - watch:
      - file: sift-python3-package-amcache

sift-python3-package-amcache-symlink:
  file.symlink:
    - name: /usr/local/bin/amcache.py
    - target: /opt/amcache/bin/amcache.py
    - makedirs: False
    - force: True
    - require:
      - file: sift-python3-package-amcache
