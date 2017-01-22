wbtools-scripts:
  file.recurse:
    - name: /usr/local/bin
    - source: salt://sift/files/wbtools
    - file_mode: 755
  
