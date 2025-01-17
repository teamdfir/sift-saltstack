# Name: analyzeMFT
# Website: https://github.com/rowingdude/analyzeMFT
# Description: NTFS MFT File Parser
# Category: 
# Author: Benjamin Cance
# License: MIT License (https://github.com/rowingdude/analyzeMFT/blob/master/LICENSE.txt)
# Notes: analyzemft

{% set commit = 'b1d0e6a0aa58d42000bfdb8e6588513bd62eaeab' %}

include:
  - sift.packages.python3-virtualenv
  - sift.packages.git

sift-python3-package-analyzemft-virtualenv:
  virtualenv.managed:
    - name: /opt/analyzemft
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-analyzemft:
  pip.installed:
    - name: git+https://github.com/rowingdude/analyzemft.git@{{ commit }}
    - bin_env: /opt/analyzemft/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-analyzemft-virtualenv
      - sls: sift.packages.git

sift-python3-package-analyzemft-symlink:
  file.symlink:
    - name: /usr/local/bin/analyzemft
    - target: /opt/analyzemft/bin/analyzemft
    - makedirs: False
    - require:
      - pip: sift-python3-package-analyzemft
