include:
  - sift.tools.densityscout

sift-tools:
  test.nop:
    - name: sift-tools
    - require:
      - sls: sift.tools.densityscout
