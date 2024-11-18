include:
  - sift.scripts.afterglow
  - sift.scripts.cyberchef
  - sift.scripts.densityscout
  - sift.scripts.dumbpig
  - sift.scripts.dump-mft-entry
  - sift.scripts.keydet-tools
  - sift.scripts.pdf-tools
  - sift.scripts.regripper
  - sift.scripts.screen-scale
  - sift.scripts.sift
  - sift.scripts.sorter
  - sift.scripts.sqlite_miner

sift-scripts:
  test.nop:
    - name: sift-scripts
    - require:
      - sls: sift.scripts.afterglow
      - sls: sift.scripts.cyberchef
      - sls: sift.scripts.densityscout
      - sls: sift.scripts.dumbpig
      - sls: sift.scripts.dump-mft-entry
      - sls: sift.scripts.keydet-tools
      - sls: sift.scripts.pdf-tools
      - sls: sift.scripts.regripper
      - sls: sift.scripts.screen-scale
      - sls: sift.scripts.sift
      - sls: sift.scripts.sorter
      - sls: sift.scripts.sqlite_miner
