include:
  - sift.scripts.4n6
  - sift.scripts.amcache
  - sift.scripts.dump-mft-entry
  - sift.scripts.image-mounter
  - sift.scripts.java-idx-parser
  - sift.scripts.misc
  - sift.scripts.packerid
  - sift.scripts.page-brute
  - sift.scripts.pdf-tools
  - sift.scripts.pe-carver
  - sift.scripts.regripper
  - sift.scripts.rfc
  - sift.scripts.shim-cache-parser
  - sift.scripts.sift
  - sift.scripts.usbdeviceforensics
  - sift.scripts.virustotal-tools
  - sift.scripts.wbtools

sift-scripts:
  test.nop:
    - name: sift-scripts
    - require:
      - sls: sift.scripts.4n6
      - sls: sift.scripts.amcache
      - sls: sift.scripts.dump-mft-entry
      - sls: sift.scripts.image-mounter
      - sls: sift.scripts.java-idx-parser
      - sls: sift.scripts.misc
      - sls: sift.scripts.packerid
      - sls: sift.scripts.page-brute
      - sls: sift.scripts.pdf-tools
      - sls: sift.scripts.pe-carver
      - sls: sift.scripts.regripper
      - sls: sift.scripts.rfc
      - sls: sift.scripts.shim-cache-parser
      - sls: sift.scripts.sift
      - sls: sift.scripts.usbdeviceforensics
      - sls: sift.scripts.virustotal-tools
      - sls: sift.scripts.wbtools
