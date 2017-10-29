include:
  - sift.packages.foremost

sift-scripts-foremost-config:
  file.managed:
    - name: /etc/foremost.conf
    - source: salt://sift/files/foremost/foremost.conf
    - required:
      - pkg: foremost

sift-scripts-foremost-config-usr-local:
  file.managed:
    - name: /usr/local/etc/foremost.conf
    - source: salt://sift/files/foremost/foremost.conf
    - makedirs: True
    - required:
      - pkg: foremost
