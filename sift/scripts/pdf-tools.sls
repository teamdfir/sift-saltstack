sift-scripts-pdf-tools:
  file.recurse:
    - name: /usr/local/bin
    - source: salt://sift/files/pdf-tools
    - file_mode: 755
  
sift-scripts-pdf-tools-helloworld-shebang:
  file.prepend:
    - name: /usr/local/bin/make-pdf-helloworld.py
    - text: '#!/usr/bin/env python2'
    - watch:
      - file: sift-scripts-pdf-tools

