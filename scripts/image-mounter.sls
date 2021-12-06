# source=https://github.com/kevthehermit/Scripts
# license=unknown

{% set commit = "28b3e08a5ad16576ffe487691376f3e2a2bc0cf5" -%}
{% set hash = "sha256=7e810482b5aa58f8085a7a03be266c113530145306c73c75ba9956ba83e39151" -%}

sift-scripts-image-mounter:
  file.managed:
    - name: /usr/local/bin/imageMounter.py
    - source: https://raw.githubusercontent.com/kevthehermit/Scripts/{{ commit }}/imageMounter.py
    - source_hash: {{ hash }}
    - mode: 755

sift-scripts-image-mounter-shebang:
  file.replace:
    - name: /usr/local/bin/imageMounter.py
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/usr/bin/env python2\n'
    - count: 1
    - prepend_if_not_found: False
    - watch:
      - file: sift-scripts-image-mounter
