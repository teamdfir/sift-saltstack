# source=https://github.com/threeplanetssoftware/sqlite_miner
# license=GNUv3

{% set commit     = "a475b7003942831c7c34d22311b4ef84237db92e" -%}
{% set hash_fun   = "sha256=c2e887dc62cb8191e0333f95d2e0eee330f62a778abf394f2ae158be39e44590" -%}
{% set hash_miner = "sha256=efb7150f346fc8db768400dbcfa2ddcae0d2be44562d3cf88c814e494f5758d5" -%}

include:
  - sift.packages.perl

sift-scripts-sqlite-miner-funstuff:
  file.managed:
    - name: /usr/local/bin/fun_stuff.pl
    - source: https://raw.githubusercontent.com/threeplanetssoftware/sqlite_miner/{{ commit }}/fun_stuff.pl
    - source_hash: {{ hash_fun }}
    - mode: 755
    - require:
      - sls: sift.packages.perl

sift-scripts-sqlite-miner:
  file.managed:
    - name: /usr/local/bin/sqlite_miner.pl
    - source: https://raw.githubusercontent.com/threeplanetssoftware/sqlite_miner/{{ commit }}/sqlite_miner.pl
    - source_hash: {{ hash_miner }}
    - mode: 755
    - require:
      - sls: sift.packages.perl

sift-scripts-sqlite-miner-shebang:
  file.prepend:
    - name: /usr/local/bin/sqlite_miner.pl
    - text: '#!/usr/bin/env perl'
    - watch:
      - file: sift-scripts-sqlite-miner
