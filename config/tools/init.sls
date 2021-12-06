include:
  - sift.config.tools.foremost
  
sift-config-tools:
  test.nop:
    - name: sift-config-tools
    - require:
      - sls: sift.config.tools.foremost
