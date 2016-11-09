java-idx-parser-scripts:
  file.recurse:
    - name: /usr/local/bin
    - source: salt://sift/files/java-idx-parser
    - file_mode: 755
    - include_pat: '*.py'
