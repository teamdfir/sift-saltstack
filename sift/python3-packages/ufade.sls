# Name: UFADE
# Website: https://github.com/prosch88/UFADE
# Description: Extraction tool for Apple mobile devices
# Category: Mobile
# Author: Christian Peter (prosch88)
# License: GNU General Public License 3 (https://github.com/prosch88/UFADE/blob/main/LICENSE)
# Notes: ufade_gui.py

{% set commit = 'fd585a97572d7e773fa1aa8d1671c36b4afe63a8' %}

include:
  - sift.packages.python3-virtualenv
  - sift.packages.git
  - sift.packages.libasound2-dev
  - sift.packages.python3-tk
  - sift.packages.libcairo2-dev
  - sift.packages.libgirepository
  - sift.packages.pkg-config
  - sift.packages.python3-dev

sift-python3-package-ufade-virtualenv:
  virtualenv.managed:
    - name: /opt/ufade
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - pymobiledevice3
      - pyiosbackup
      - iOSbackup
      - pandas
      - pyarrow==20
      - simpleaudio-patched
      - NSKeyedUnArchiver==1.5
      - paramiko
      - customtkinter
      - tkcalendar
      - crossfiledialog
      - exifread<3
      - pdfme
      - imagehash
  {% if grains['oscodename'] == "jammy" %}
      - pygobject<=3.48.2
  {% else %}
      - pygobject
  {% endif %}
      - pycairo
    - require:
      - sls: sift.packages.python3-virtualenv
      - sls: sift.packages.libasound2-dev
      - sls: sift.packages.python3-tk
      - sls: sift.packages.libcairo2-dev
      - sls: sift.packages.libgirepository
      - sls: sift.packages.pkg-config
      - sls: sift.packages.python3-dev

sift-python3-package-ufade-git:
  git.latest:
    - name: https://github.com/prosch88/UFADE.git
    - target: /opt/ufade/UFADE
    - rev: {{ commit }}
    - force_clone: True
    - force_reset: True
    - submodules: True
    - require:
      - virtualenv: sift-python3-package-ufade-virtualenv
      - sls: sift.packages.git

sift-python3-package-ufade-shebang:
  file.replace:
    - name: /opt/ufade/UFADE/ufade_gui.py
    - pattern: '#!/usr/bin/env python3'
    - repl: '#!/opt/ufade/bin/python3'
    - count: 1
    - require:
      - git: sift-python3-package-ufade-git

sift-python3-package-ufade-permissions:
  file.managed:
    - name: /opt/ufade/UFADE/ufade_gui.py
    - replace: False
    - mode: 755
    - require:
      - file: sift-python3-package-ufade-shebang

sift-python3-package-ufade-symlink:
  file.managed:
    - name: /usr/local/bin/ufade
    - contents: |
        #!/bin/bash
        (cd /opt/ufade/UFADE; ./ufade_gui.py) &
    - makedirs: False
    - force: True
    - mode: 755
    - require:
      - file: sift-python3-package-ufade-shebang
      - file: sift-python3-package-ufade-permissions
