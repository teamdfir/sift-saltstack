# Name: mac_apt
# Website: https://github.com/ydkhatri/mac_apt
# Description: macOS and iOS Artifact Parsing Tool
# Category:
# Author: Yogesh Khatri
# License: MIT License (https://github.com/ydkhatri/mac_apt/blob/master/LICENSE.txt)
# Notes: mac_apt.py, mac_apt_artifact_only.py, mac_apt_mounted_sys_data.py, ios_apt.py, extract_apfs_fs.py

{% set files = ['mac_apt.py','mac_apt_artifact_only.py','mac_apt_mounted_sys_data.py','ios_apt.py','extract_apfs_fs.py'] %}

include:
  - sift.packages.python3-virtualenv
  - sift.packages.python3-dev
  - sift.packages.libbz2-dev
  - sift.packages.zlib1g-dev
  - sift.packages.git

sift-python3-package-mac-apt-venv:
  virtualenv.managed:
    - name: /opt/mac-apt
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - pybindgen==0.21.0
    - require:
      - sls: sift.packages.python3-virtualenv
      - sls: sift.packages.python3-dev
      - sls: sift.packages.libbz2-dev
      - sls: sift.packages.zlib1g-dev

sift-python3-package-mac-apt-git:
  git.latest:
    - name: https://github.com/ydkhatri/mac_apt.git
    - target: /opt/mac-apt/bin/mac_apt_git/
    - user: root
    - rev: master
    - force_clone: True
    - force_reset: True
    - require:
      - sls: sift.packages.git
      - virtualenv: sift-python3-package-mac-apt-venv

sift-python3-package-mac-apt-requirements:
  pip.installed:
    - bin_env: /opt/mac-apt/bin/python3
    - requirements: /opt/mac-apt/bin/mac_apt_git/requirements.txt
    - upgrade: False
    - cwd: /opt/mac-apt/bin/mac_apt_git/
    - require:
      - git: sift-python3-package-mac-apt-git

{% for file in files %}

sift-python3-package-mac-apt-chmod-{{ file }}:
  file.managed:
    - name: /opt/mac-apt/bin/mac_apt_git/{{ file }}
    - mode: 755
    - require:
      - pip: sift-python3-package-mac-apt-requirements

sift-python3-package-mac-apt-prepend-{{ file }}:
  file.prepend:
    - name: /opt/mac-apt/bin/mac_apt_git/{{ file }}
    - text: '#!/opt/mac-apt/bin/python3'
    - watch:
      - file: sift-python3-package-mac-apt-chmod-{{ file }}

sift-python3-package-mac-apt-fix-crlf-{{ file }}:
  file.replace:
    - name: /opt/mac-apt/bin/mac_apt_git/{{ file }}
    - pattern: '\r'
    - repl: ''
    - require:
      - file: sift-python3-package-mac-apt-prepend-{{ file }}

sift-python3-package-mac-apt-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/mac-apt/bin/mac_apt_git/{{ file }}
    - makedirs: False
    - require:
      - file: sift-python3-package-mac-apt-fix-crlf-{{ file }}

{% endfor %}
