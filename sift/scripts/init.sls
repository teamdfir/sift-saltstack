include:
  - sift.scripts.4n6
  - sift.scripts.amcache
  - sift.scripts.cyberchef
  - sift.scripts.densityscout
  - sift.scripts.dump-mft-entry
  - sift.scripts.exiftool
  - sift.scripts.keydet-tools
  - sift.scripts.packerid
  - sift.scripts.pdf-tools
  - sift.scripts.regripper
  - sift.scripts.screen-scale
  - sift.scripts.shim-cache-parser
  - sift.scripts.sift
  - sift.scripts.sorter
  - sift.scripts.virustotal-tools
  - sift.scripts.vshot
  - sift.scripts.zimmerman

sift-scripts:
  test.nop:
    - name: sift-scripts
    - require:
      - sls: sift.scripts.4n6
      - sls: sift.scripts.amcache
      - sls: sift.scripts.cyberchef
      - sls: sift.scripts.densityscout
      - sls: sift.scripts.dump-mft-entry
      - sls: sift.scripts.exiftool
      - sls: sift.scripts.keydet-tools
      - sls: sift.scripts.packerid
      - sls: sift.scripts.pdf-tools
      - sls: sift.scripts.regripper
      - sls: sift.scripts.screen-scale
      - sls: sift.scripts.shim-cache-parser
      - sls: sift.scripts.sift
      - sls: sift.scripts.sorter
      - sls: sift.scripts.virustotal-tools
      - sls: sift.scripts.vshot
      - sls: sift.scripts.zimmerman
