# source=https://github.com/superponible/DFIR
# license=unknown

{% set commit = "ee681a07a0c32a5ccaea788cd7d012d19872f181" -%}
{% set hash = "7141258a36037653dd377d062350f703b90c99e70c9e3d38f86fcd8c70258e1b" -%}

sift-scripts-dump-mft-entry:
  file.managed:
    - name: /usr/local/bin/dump-mft-entry.pl
    - source: https://raw.githubusercontent.com/superponible/DFIR/{{ commit }}/dump_mft_entry.pl
    - source_hash: sha256={{ hash }}
    - mode: 755

sift-scripts-dump-mft-entry-shebang:
  file.replace:
    - name: /usr/local/bin/dump-mft-entry.pl
    - pattern: '#!/usr/bin/perl'
    - repl: '#!/usr/bin/env perl'
    - count: 1
    - watch:
      - file: sift-scripts-dump-mft-entry
