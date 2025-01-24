# Name: stix-validator
# Website: https://stixproject.github.io/
# Description: Tool for using the Structured Threat Information eXpression language
# Category: 
# Author: The MITRE Corporation
# License: BSD 3-Clause (https://github.com/STIXProject/stix-validator/blob/master/LICENSE.txt)
# Notes: stix-validator

include:
  - sift.packages.python3-virtualenv

sift-python3-package-stix-validator-venv:
  virtualenv.managed:
    - name: /opt/stix-validator
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - lxml
      - stix
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-stix-validator:
  pip.installed:
    - name: stix-validator
    - bin_env: /opt/stix-validator/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-stix-validator-venv

sift-python3-package-stix-validator-symlink:
  file.symlink:
    - name: /usr/local/bin/stix-validator
    - target: /opt/stix-validator/bin/stix-validator
    - makedirs: False
    - require:
      - pip: sift-python3-package-stix-validator
