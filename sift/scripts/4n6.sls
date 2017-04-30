scripts-4n6:
  file.recurse:
    - name: /usr/local/bin
    - source: salt://sift/files/4n6-scripts
    - file_mode: 755
