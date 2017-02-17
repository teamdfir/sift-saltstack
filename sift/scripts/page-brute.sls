page-brute:
  file.recurse:
    - name: /usr/local/bin
    - source: salt://sift/files/page-brute
    - file_mode: 755
    - include_pat: '*.py'
