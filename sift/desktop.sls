include:
  - sift.server
  - sift.config

sift-desktop-version-file:
  file.managed:
    - name: /etc/sift-version
    - source: salt://VERSION
    - user: root
    - group: root
    - require:
      - sls: sift.server
      - sls: sift.config
