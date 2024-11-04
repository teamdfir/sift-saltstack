include:
  - sift.python3-packages.pip
  - sift.python3-packages.setuptools
  - sift.python3-packages.setuptools-rust
  - sift.python3-packages.keyrings-alt
  
sift-python3-packages-pyhindsight:
  pip.installed:
    - name: pyhindsight
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip
      - sls: sift.python3-packages.setuptools
      - sls: sift.python3-packages.setuptools-rust
      - sls: sift.python3-packages.keyrings-alt

sift-python3-packages-pyhindsight-encoding:
  file.replace:
    - name: /usr/local/bin/hindsight.py
    - pattern: '\r'
    - repl: ''
    - require:
      - pip: sift-python3-packages-pyhindsight

sift-python3-packages-pyhindsight-chmod:
  file.managed:
    - name: /usr/local/bin/hindsight.py
    - mode: 755
    - watch:
      - file: sift-python3-packages-pyhindsight-encoding

sift-python3-packages-pyhindsight-gui-encoding:
  file.replace:
    - name: /usr/local/bin/hindsight_gui.py
    - pattern: '\r'
    - repl: ''
    - require:
      - pip: sift-python3-packages-pyhindsight

sift-python3-packages-pyhindsight-gui-prepend:
  file.replace:
    - name: /usr/local/bin/hindsight_gui.py
    - pattern: '#!/usr/bin/env python3'
    - repl: '#!/usr/bin/env python3'
    - prepend_if_not_found: True
    - count: 1
    - require:
      - pip: sift-python3-packages-pyhindsight

sift-python3-packages-pyhindsight-gui-chmod:
  file.managed:
    - name: /usr/local/bin/hindsight_gui.py
    - mode: 755
    - watch:
      - file: sift-python3-packages-pyhindsight-gui-prepend


