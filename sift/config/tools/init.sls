include:
  - sift.config.tools.foremost
  - sift.config.tools.perl-modules
  - sift.config.tools.windows-forensic-analysis
  
sift-config-tools:
  test.nop:
    - name: sift-config-tools
    - require:
      - sls: sift.config.tools.foremost
      - sls: sift.config.tools.perl-modules
      - sls: sift.config.tools.windows-forensic-analysis
