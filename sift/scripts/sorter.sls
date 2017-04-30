scripts-sorter-directory:
  file.directory:
    - name: /usr/share/tsk/sorter
    - makedirs: true

scripts-sorter-files:
  file.recurse:
    - name: /usr/share/tsk/sorter
    - source: salt://sift/files/sorter
    - file_mode: 644
    - require:
      - file: scripts-sorter-directory
