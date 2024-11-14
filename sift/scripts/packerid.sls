# source=https://github.com/sooshie/packerid
# license=Unknown

{% set commit = "7b2ee6ef57db903bf356fd342c8ca998abdb68cd" -%}
{% set hash = "sha256=be589d4cbe70ecdc3424a6da48d8fc24630d51a6ebf92e5328b36e39423eb038" -%}

include:
  - sift.python3-packages.core
  - sift.python3-packages.pefile
  - sift.python3-packages.capstone

sift-scripts-packerid:
  file.managed:
    - name: /usr/local/bin/packerid.py
    - source: https://raw.githubusercontent.com/sooshie/packerid/{{ commit }}/packerid.py
    - source_hash: {{ hash }}
    - mode: 755
    - require:
      - sls: sift.python3-packages.core
      - sls: sift.python3-packages.pefile
      - sls: sift.python3-packages.capstone

sift-scripts-packerid-shebang:
  file.replace:
    - name: /usr/local/bin/packerid.py
    - pattern: '#!/usr/local/bin/python'
    - repl: '#!/usr/bin/env python3'
    - count: 1
    - watch:
      - file: sift-scripts-packerid
