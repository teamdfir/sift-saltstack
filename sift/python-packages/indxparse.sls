{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- set commit = "ca08236b0f70798cb6f89785820c9b82ee0c66ff" -%}

include:
  - sift.packages.git
  - sift.packages.g++
  - sift.packages.libfuse-dev
  - sift.packages.pkg-config
  - sift.packages.python3
  - sift.packages.python3-pip
  - sift.packages.python3-wxgtk3

sift-python-package-indxparse:
  pip.installed:
    - name: git+https://github.com/williballenthin/INDXParse.git@{{ commit }}
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.g++
      - sls: sift.packages.pkg-config
      - sls: sift.packages.python3-pip
      - sls: sift.packages.libfuse-dev
      - sls: sift.packages.python3-wxgtk3

sift-python-package-indxparse-shebang:
  file.prepend:
    - name: /usr/local/bin/INDXParse.py
    - text: '#!/usr/bin/env python'
    - watch:
      - pip: sift-python-package-indxparse
