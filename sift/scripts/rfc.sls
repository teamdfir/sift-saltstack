sift-scripts-rfc:
  file.managed:
    - name: /usr/local/bin/rfc.pl
    - source: salt://sift/files/scripts/rfc.pl
    - file_mode: 755
