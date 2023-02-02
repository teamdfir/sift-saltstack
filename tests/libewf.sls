include:
  - sift.repos.sift
  - sift.repos.gift
  - sift.packages.autopsy
  - sift.packages.libewf
  - sift.packages.python3
  - sift.packages.python3-xlsxwriter
  - sift.packages.python3-dfvfs
  - sift.packages.python3-plaso
  - sift.packages.sleuthkit
  - sift.packages.xmount

sift-tests-libewf:
  test.nop:
    - name: test-libewf
    - require:
      - sls: sift.repos.sift
      - sls: sift.repos.gift
      - sls: sift.packages.autopsy
      - sls: sift.packages.libewf
      - sls: sift.packages.python3
      - sls: sift.packages.python3-xlsxwriter
      - sls: sift.packages.python3-dfvfs
      - sls: sift.packages.python3-plaso
      - sls: sift.packages.sleuthkit
      - sls: sift.packages.xmount
