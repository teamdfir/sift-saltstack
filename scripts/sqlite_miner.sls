# Name: sqlite_miner
# Website: https://github.com/threeplanetssoftware/sqlite_miner
# Description: A script to mine SQLite databases for hidden gems that might be overlooked 
# Category: 
# Author: Jon Baumann, Ciofeca Forensics
# License: GNU General Public License v3.0 (https://github.com/threeplanetssoftware/sqlite_miner/blob/master/LICENSE)
# Notes: sqlite_miner.pl, fun_stuff.pl

{% set commit     = "4220dae48a6e45c1316b153231dc6beef36f2f59" -%}
{% set hash_fun   = "sha256=c2e887dc62cb8191e0333f95d2e0eee330f62a778abf394f2ae158be39e44590" -%}
{% set hash_miner = "sha256=0d4b380a27dd57380b581224b1258fbd5059b9314d59aa7ee2f260d352f82278" -%}

include:
  - sift.packages.perl
  - sift.perl-packages.dbd-sqlite

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
    - source: https://raw.githubusercontent.com/threeplanetssoftware/sqlite_miner/master/sqlite_miner.pl
    - source_hash: {{ hash_miner }}
    - mode: 755
    - require:
      - sls: sift.packages.perl
      - sls: sift.perl-packages.dbd-sqlite

sift-scripts-sqlite-miner-shebang:
  file.prepend:
    - name: /usr/local/bin/sqlite_miner.pl
    - text: '#!/usr/bin/env perl'
    - watch:
      - file: sift-scripts-sqlite-miner
