# Name: Java_IDX_Parser
# Website: https://github.com/digitalsleuth/Java_IDX_Parser
# Description: Parses Java Cache IDX files
# Category: 
# Author: Brian Baskin and Corey Forman (digitalsleuth)
# License: Apache License 2.0 (https://github.com/digitalsleuth/Java_IDX_Parser/blob/master/LICENSE)
# Notes: idx-parser

include:
  - sift.packages.python3-virtualenv

sift-python3-package-java-idx-parser-venv:
  virtualenv.managed:
    - name: /opt/java-idx-parser
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-java-idx-parser:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/Java_IDX_Parser.git
    - bin_env: /opt/java-idx-parser/bin/python3
    - replace: True
    - mode: 755
    - require:
      - virtualenv: sift-python3-package-java-idx-parser-venv

sift-python3-package-java-idx-parser-symlink:
  file.symlink:
    - name: /usr/local/bin/idx-parser
    - target: /opt/java-idx-parser/bin/idx-parser
    - makedirs: False
    - require:
      - pip: sift-python3-package-java-idx-parser
