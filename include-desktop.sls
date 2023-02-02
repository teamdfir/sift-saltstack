include:
  - sift.server
  - sift.config

sift-desktop-include:
  test.nop:
    - name: sift-desktop-include
    - requires:
      - sls: sift.server
      - sls: sift.config