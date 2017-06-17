{%- set commit = "1a669eada6f7933798751e0cf482a9eb654c739b" -%}
{%- set hash = "1065c23fdea1fde90e931bf5ccabc93b508bee0f6855a6ef2b3b9fd74495e279" -%}
# Source: https://github.com/Rurik/Java_IDX_Parser
# License: https://github.com/Rurik/Java_IDX_Parser#copyright-and-license
sift-scripts-amcache:
  file.managed:
    - name: /usr/local/bin/amcache.py
    - source: https://raw.githubusercontent.com/williballenthin/python-registry/{{ commit }}/samples/amcache.py
    - source_hash: sha256={{ hash }}
    - mode: 755

sift-scripts-amcache-shebang:
  file.replace:
    - name: /usr/local/bin/amcache.py
    - pattern: '#!/usr/bin/python'
    - repl: '#!/usr/bin/env python'
    - count: 1
    - watch:
      - file: sift-scripts-amcache
