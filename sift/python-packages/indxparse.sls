{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- set commit = "1b32736cf9f15d916f7c026346be068fdbe86cf2" -%}

include:
  - ..packages.git
  - ..packages.pkg-config
  - ..packages.python-pip

sift-python-package-indxparse:
  pip.installed:
    - name: git+https://github.com/williballenthin/INDXParse.git@{{ commit }}
    - require:
      - pkg: git
      - pkg: pkg-config
      - pkg: python-pip

sift-python-package-indxparse-shebang:
  file.prepend:
    - name: /usr/local/bin/INDXParse.py
    - text: '#!/usr/bin/env python'
    - watch:
      - pip: sift-python-package-indxparse
