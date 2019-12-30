# source=https://github.com/threeplanetssoftware/sqlite_miner
# license=GNUv3

{% set commit     = "4220dae48a6e45c1316b153231dc6beef36f2f59" -%}
{% set hash_fun   = "sha256=c2e887dc62cb8191e0333f95d2e0eee330f62a778abf394f2ae158be39e44590" -%}
{% set hash_miner = "sha256=19ed304989d7963b80530367caf4113810a55910147a7af41160d7f584614505" -%}

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

