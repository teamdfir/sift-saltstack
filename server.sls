include:
  - sift.include-server

sift-server-version-file:
  test.nop:
    - name: install-complete
    - require:
      - sls: sift.include-server
