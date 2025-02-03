# Name: page-brute
# Website: https://github.com/digitalsleuth/page-brute
# Description: Page File analysis tool
# Category:
# Author: Corey Forman (digitalsleuth) and Michael Matonis (matonis)
# License: Unknown
# Notes: page-brute

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
  pip.installed:
    - name: page-brute
    - bin_env: /opt/page-brute/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-page-brute-venv

sift-python3-package-page-brute-symlink:
  file.symlink:
    - name: /usr/local/bin/page-brute
    - target: /opt/page-brute/bin/page-brute
    - makedirs: False
    - require:
      - pip: sift-python3-package-page-brute
