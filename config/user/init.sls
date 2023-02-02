include:
  - sift.config.user.user
  - sift.config.user.bash-aliases
  - sift.config.user.bash-rc
  - sift.config.user.folders
  - sift.config.user.pdfs
  - sift.config.user.ssh
  - sift.config.user.symlinks
  - sift.config.user.terminal
  - sift.config.user.theme

sift-config-user:
  test.nop:
    - name: sift-config-user
    - require:
      - sls: sift.config.user.user
      - sls: sift.config.user.bash-aliases
      - sls: sift.config.user.bash-rc
      - sls: sift.config.user.folders
      - sls: sift.config.user.pdfs
      - sls: sift.config.user.ssh
      - sls: sift.config.user.symlinks
      - sls: sift.config.user.terminal
      - sls: sift.config.user.theme
