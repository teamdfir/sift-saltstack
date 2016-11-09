/usr/share/tsk/sorter:
  file.directory:
    - makedirs: true

sorter-files:
  file.recurse:
    - name: /usr/share/tsk/sorter
    - source: salt://sift/files/sorter
    - file_mode: 644
