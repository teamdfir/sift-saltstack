# source=https://github.com/gleeda/misc-scripts
# license=gplv2

include:
  - sift.packages.python3-virtualenv

sift-python3-package-job-parser-venv:
  virtualenv.managed:
    - name: /opt/job-parser
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-job-parser-copy:
  file.managed:
    - name: /opt/job-parser/bin/jobparser.py
    - source: salt://sift/files/jobparser/jobparser.py
    - replace: True
    - mode: 755
    - require:
      - virtualenv: sift-python3-package-job-parser-venv

sift-python3-package-job-parser-shebang:
  file.replace:
    - name: /opt/job-parser/bin/jobparser.py
    - pattern: '#!/usr/bin/env python3'
    - repl: '#!/opt/job-parser/bin/python3'
    - count: 1
    - watch:
      - file: sift-python3-package-job-parser-copy

sift-python3-package-job-parser-symlink:
  file.symlink:
    - name: /usr/local/bin/jobparser.py
    - target: /opt/job-parser/bin/jobparser.py
    - makedirs: False
    - require:
      - file: sift-python3-package-job-parser-shebang
