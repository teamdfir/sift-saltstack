include:
  - sift.include-desktop

sift-desktop-version-file:
  test.nop:
    - name: install-complete
    - require:
      - sls: sift.include-server
