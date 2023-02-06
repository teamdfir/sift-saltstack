# source=https://github.com/mandiant/ShimCacheParser
# license=apache2
# license_source=https://github.com/mandiant/ShimCacheParser/blob/master/LICENSE

{% set commit = "d7c517af9f3b09b810c5859ee52a6540f3b25855" -%}
{% set shasum = "sha256=61e75e485c0efc862e7b1c7746a493ca944afcf3e96512fb864706089f89d9aa" -%}

include:
  - sift.python-packages.python-registry

sift-scripts-shim-cache-parser:
  file.managed:
    - name: /usr/local/bin/ShimCacheParser.py
    - source: https://raw.githubusercontent.com/mandiant/ShimCacheParser/{{ commit }}/ShimCacheParser.py
    - source_hash: {{ shasum }}
    - mode: 755
    - require:
      - sls: sift.python-packages.python-registry

sift-scripts-shim-cache-parser-shebang:
  file.prepend:
    - name: /usr/local/bin/ShimCacheParser.py
    - text: '#!/usr/bin/env python2'
    - watch:
      - file: sift-scripts-shim-cache-parser
