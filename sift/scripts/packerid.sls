# source=https://github.com/sooshie/packerid
# license=Unknown

{% set commit = "7b2ee6ef57db903bf356fd342c8ca998abdb68cd" -%}
{% set hash = "sha256=be589d4cbe70ecdc3424a6da48d8fc24630d51a6ebf92e5328b36e39423eb038" -%}

include:
  - sift.packages.python2
  - sift.python-packages.pefile
  - sift.python-packages.capstone

sift-scripts-packerid:
  file.managed:
    - name: /usr/local/bin/packerid.py
    - source: https://raw.githubusercontent.com/sooshie/packerid/{{ commit }}/packerid.py
    - source_hash: {{ hash }}
    - mode: 755
    - require:
      - sls: sift.packages.python2
      - sls: sift.python-packages.pefile
      - sls: sift.python-packages.capstone

sift-scripts-packerid-shebang:
  file.replace:
    - name: /usr/local/bin/packerid.py
    - pattern: '#!/usr/local/bin/python'
    - repl: '#!/usr/bin/env python2'
    - count: 1
    - watch:
      - file: sift-scripts-packerid
