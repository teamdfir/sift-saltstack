include:
  - sift.scripts.4n6
  - sift.scripts.java-idx-parser
  - sift.scripts.misc
  - sift.scripts.page-brute
  - sift.scripts.pdf-tools
  - sift.scripts.pe-carver
  - sift.scripts.regripper
  - sift.scripts.sift
  - sift.scripts.volatility
  - sift.scripts.wbtools

sift-scripts:
  test.nop:
    - name: sift-scripts
    - require:
      - sls: sift.scripts.4n6
      - sls: sift.scripts.java-idx-parser
      - sls: sift.scripts.misc
      - sls: sift.scripts.page-brute
      - sls: sift.scripts.pdf-tools
      - sls: sift.scripts.pe-carver
      - sls: sift.scripts.regripper
      - sls: sift.scripts.sift
      - sls: sift.scripts.volatility
      - sls: sift.scripts.wbtools
