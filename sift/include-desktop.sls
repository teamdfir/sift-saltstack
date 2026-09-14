include:
  - sift.server
  - sift.config

sift-desktop-include:
  test.nop:
    - name: sift-desktop-include
    - require:
      - sls: sift.server
      - sls: sift.config
