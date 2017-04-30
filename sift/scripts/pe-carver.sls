scripts-pe-carver:
  file.recurse:
    - name: /usr/local/bin
    - source: salt://sift/files/pe-carver
    - file_mode: 755
    - include_pat: '*.py'
