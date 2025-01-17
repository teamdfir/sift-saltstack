include:
  - sift.scripts.4n6
  - sift.scripts.afterglow
  - sift.scripts.amcache
  - sift.scripts.cyberchef
  - sift.scripts.densityscout
  - sift.scripts.dumbpig
  - sift.scripts.dump-mft-entry
  - sift.scripts.image-mounter
  - sift.scripts.java-idx-parser
  - sift.scripts.jobparser
  - sift.scripts.keydet-tools
  - sift.scripts.packerid
  - sift.scripts.page-brute
  - sift.scripts.parseusn
  - sift.scripts.pdf-tools
  - sift.scripts.pe-carver
  - sift.scripts.pescanner
  - sift.scripts.regripper
  - sift.scripts.screen-scale
  - sift.scripts.shim-cache-parser
  - sift.scripts.sift
  - sift.scripts.sorter
  - sift.scripts.sqlite_miner
  - sift.scripts.sqlparser
  - sift.scripts.usbdeviceforensics
  - sift.scripts.virustotal-tools
  - sift.scripts.vshot
  - sift.scripts.zimmerman

sift-scripts:
  test.nop:
    - name: sift-scripts
    - require:
      - sls: sift.scripts.4n6
      - sls: sift.scripts.afterglow
      - sls: sift.scripts.amcache
      - sls: sift.scripts.cyberchef
      - sls: sift.scripts.densityscout
      - sls: sift.scripts.dumbpig
      - sls: sift.scripts.dump-mft-entry
      - sls: sift.scripts.image-mounter
      - sls: sift.scripts.java-idx-parser
      - sls: sift.scripts.jobparser
      - sls: sift.scripts.keydet-tools
      - sls: sift.scripts.packerid
      - sls: sift.scripts.page-brute
      - sls: sift.scripts.parseusn
      - sls: sift.scripts.pdf-tools
      - sls: sift.scripts.pe-carver
      - sls: sift.scripts.pescanner
      - sls: sift.scripts.regripper
      - sls: sift.scripts.screen-scale
      - sls: sift.scripts.shim-cache-parser
      - sls: sift.scripts.sift
      - sls: sift.scripts.sorter
      - sls: sift.scripts.sqlite_miner
      - sls: sift.scripts.sqlparser
      - sls: sift.scripts.usbdeviceforensics
      - sls: sift.scripts.virustotal-tools
      - sls: sift.scripts.vshot
      - sls: sift.scripts.zimmerman
