include:
  - sift.tools.densityscout
  - sift.tools.sift-cli

sift-tools:
  test.nop:
    - name: sift-tools
    - require:
      - sls: sift.tools.densityscout
      - sls: sift.tools.sift-cli
