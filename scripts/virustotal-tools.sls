# source=https://blog.didierstevens.com/programs/virustotal-tools/
# license=unknown

include:
  - sift.python-packages.poster

sift-scripts-virustotal-search-archive:
  archive.extracted:
    - name: /usr/local/src/virustotal-search-v0.1.4
    - source: https://didierstevens.com/files/software/virustotal-search_V0_1_4.zip
    - source_hash: sha256=8c033b3c46767590c54c191aeedc0162b3b8ccde0d7b75841a6552ca9de76044
    - enforce_toplevel: False

sift-scripts-virustotal-search-script:
  file.managed:
    - name: /usr/local/bin/virustotal-search.py
    - source: /usr/local/src/virustotal-search-v0.1.4/virustotal-search.py
    - mode: 755
    - watch:
      - archive: sift-scripts-virustotal-search-archive

sift-scripts-virustotal-submit-archive:
  archive.extracted:
    - name: /usr/local/src/virustotal-submit-v0.0.3
    - source: https://didierstevens.com/files/software/virustotal-submit_V0_0_3.zip
    - source_hash: sha256=37cce3e8469de097912cb23bac6b909c9c7f5a5cee09c9279d32bdb9d6e23bcc
    - enforce_toplevel: False

sift-scripts-virustotal-submit-script:
  file.managed:
    - name: /usr/local/bin/virustotal-submit.py
    - source: /usr/local/src/virustotal-submit-v0.0.3/virustotal-submit.py
    - mode: 755
    - watch:
      - archive: sift-scripts-virustotal-submit-archive
    - require:
      - sls: sift.python-packages.poster

sift-scripts-virustotal-search-shebang:
  file.replace:
    - name: /usr/local/bin/virustotal-search.py
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/usr/bin/env python2\n'
    - count: 1
    - watch:
      - file: sift-scripts-virustotal-search-script

sift-scripts-virustotal-submit-shebang:
  file.replace:
    - name: /usr/local/bin/virustotal-submit.py
    - pattern: '#!/usr/bin/env python\n'
    - repl: '#!/usr/bin/env python2\n'
    - count: 1
    - watch:
      - file: sift-scripts-virustotal-submit-script

