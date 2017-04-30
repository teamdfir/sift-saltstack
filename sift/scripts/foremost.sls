scripts-foremost-config:
  file.managed:
    - name: /etc/foremost.conf
    - source: salt://sift/files/foremost/foremost.conf
