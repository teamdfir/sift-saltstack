# source=https://github.com/Rurik/Java_IDX_Parser
# license=apache2.0
# license_source=https://github.com/Rurik/Java_IDX_Parser#copyright-and-license
# notes=Modified for python3, file stored locally at github.com/teamdfir/sift-saltstack

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

sift-python3-package-java-idx-parser-copy:
  file.managed:
    - name: /opt/java-idx-parser/bin/idx_parser.py
    - source: salt://sift/files/java-idx-parser/idx_parser.py
    - replace: True
    - mode: 755
    - require:
      - virtualenv: sift-python3-package-java-idx-parser-venv

sift-python3-package-java-idx-parser-shebang:
  file.replace:
    - name: /opt/java-idx-parser/bin/idx_parser.py
    - pattern: '#! /usr/bin/env python3'
    - repl: '#! /opt/java-idx-parser/bin/python3'
    - count: 1
    - watch:
      - file: sift-python3-package-java-idx-parser-copy

sift-python3-package-java-idx-parser-symlink:
  file.symlink:
    - name: /usr/local/bin/idx_parser.py
    - target: /opt/java-idx-parser/bin/idx_parser.py
    - makedirs: False
    - require:
      - file: sift-python3-package-java-idx-parser-shebang
