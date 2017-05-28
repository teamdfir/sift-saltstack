sift-scripts-rfc:
  file.managed:
    - name: /usr/local/bin/rfc.pl
    - source: salt://sift/files/scripts/rfc.pl
    - mode: 755
