include:
  - sift.config.user.user
  - sift.config.user.bash-aliases
  - sift.config.user.bash-rc
  - sift.config.user.folders
  - sift.config.user.pdfs
  - sift.config.user.rekall
  - sift.config.user.symlinks

sift-config-user:
  test.nop:
    - name: sift-config-user
    - require:
      - sls: sift.config.user.user
      - sls: sift.config.user.bash-aliases
      - sls: sift.config.user.bash-rc
      - sls: sift.config.user.folders
      - sls: sift.config.user.pdfs
      - sls: sift.config.user.rekall
      - sls: sift.config.user.symlinks
      
