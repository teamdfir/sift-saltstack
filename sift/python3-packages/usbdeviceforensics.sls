# Name: usbdeviceforensics
# Website: https://github.com/digitalsleuth/usbdeviceforensics
# Description: Python script to parse USB Device artifacts from Windows systems
# Category:
# Author: Mark Woan, Corey Forman (digitalsleuth)
# License: None
# Notes: usbdeviceforensics

include:
  - sift.packages.python3-virtualenv
  - sift.packages.git
  - sift.packages.python3-dev

sift-python3-package-usbdeviceforensics-venv:
  virtualenv.managed:
    - name: /opt/usbdeviceforensics
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - python-registry
      - enum34
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-usbdeviceforensics:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/usbdeviceforensics.git
    - bin_env: /opt/usbdeviceforensics/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-usbdeviceforensics-venv
      - sls: sift.packages.git
      - sls: sift.packages.python3-dev

sift-python3-package-usbdeviceforensics-symlink:
  file.symlink:
    - name: /usr/local/bin/usbdeviceforensics
    - target: /opt/usbdeviceforensics/bin/usbdeviceforensics
    - force: True
    - require:
      - pip: sift-python3-package-usbdeviceforensics
