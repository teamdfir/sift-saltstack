{%- set hash = "0bb28498141380821d5adc43cc3557ce6a96aeb8a33c414a48e3ccc2a1aad8c9" -%}
# Source: https://github.com/mdegrazia/SQLite-Deleted-Records-Parser
# License: Not Specified
sift-scripts-sqlparser:
  file.managed:
    - name: /usr/local/bin/sqlparser.py
    - source: https://github.com/mdegrazia/SQLite-Deleted-Records-Parser/releases/download/v.1.1/sqlparse_v1.1.py
    - source_hash: sha256={{ hash }}
    - mode: 755

sift-scripts-sqlparser-shebang:
  file.prepend:
    - name: /usr/local/bin/sqlparser.py
    - text: '#!/usr/bin/env python'
    - watch:
      - file: sift-scripts-sqlparser
