include:
  - sift.config.hostname
  - sift.config.user
  - sift.config.timezone
  - sift.config.folders
  - sift.config.salt-minion
  - sift.config.samba
  - sift.config.tools

sift-config:
  test.nop:
    - name: sift-config
    - require:
      - sls: sift.config.hostname
      - sls: sift.config.user
      - sls: sift.config.timezone
      - sls: sift.config.folders
      - sls: sift.config.salt-minion
      - sls: sift.config.samba
      - sls: sift.config.tools
      
