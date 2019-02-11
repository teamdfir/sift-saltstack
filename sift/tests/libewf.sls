include:
  - sift.repos.sift
  - sift.repos.gift
  - sift.packages.absent.plaso
  - sift.packages.autopsy
  - sift.packages.libewf
  - sift.packages.python
  - sift.packages.python-xlsxwriter
  - sift.packages.python-dfvfs
  - sift.packages.python-plaso
  - sift.packages.sleuthkit
  - sift.packages.xmount

sift-tests-libewf:
  test.nop:
    - name: test-libewf
    - require:
      - sls: sift.packages.absent.plaso
      - sls: sift.repos.sift
      - sls: sift.repos.gift
      - sls: sift.packages.autopsy
      - sls: sift.packages.libewf
      - sls: sift.packages.python
      - sls: sift.packages.python-xlsxwriter
      - sls: sift.packages.python-dfvfs
      - sls: sift.packages.python-plaso
      - sls: sift.packages.sleuthkit
      - sls: sift.packages.xmount
