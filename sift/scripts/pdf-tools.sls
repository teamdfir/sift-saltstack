pdf-tools-scripts:
  file.recurse:
    - name: /usr/local/bin
    - source: salt://sift/files/pdf-tools
    - file_mode: 755
  
