sift-scripts-foremost-config:
  file.managed:
    - name: /etc/foremost.conf
    - source: salt://sift/files/foremost/foremost.conf

sift-scripts-foremost-config-usr-local:
  file.managed:
    - name: /usr/local/etc/foremonst.conf
    - source: salt://sift/files/foremost/foremost.conf
