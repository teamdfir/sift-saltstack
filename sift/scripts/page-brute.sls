sift-scripts-page-brute:
  file.recurse:
    - name: /usr/local/bin
    - source: salt://sift/files/page-brute
    - file_mode: 755
    - include_pat: '*.py'

sift-scripts-page-brute-shebang:
  file.replace:
    - name: /usr/local/bin/page_brute-BETA.py
    - pattern: '#!/usr/bin/python\n'
    - repl: '#!/usr/bin/env python2\n'
    - count: 1
    - watch:
      - file: sift-scripts-page-brute
