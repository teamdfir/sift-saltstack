{%- set commit = "031d06d13189fdb8bd24b75585951b1b5b33aa56" -%}
{%- set hash = "c88bbc933bc045febd4c10267367bac3eeddbcbb9819c752f2ab44723e3ccc6f" -%}
# Source: https://github.com/keydet89/Tools
# License: Unknown
sift-scripts-rfc:
  file.managed:
    - name: /usr/local/bin/rfc.pl
    - source: https://raw.githubusercontent.com/keydet89/Tools/{{ commit }}/source/rfc.pl
    - source_hash: sha256={{ hash }}
    - mode: 755

sift-scripts-rfc-shebang:
  file.replace:
    - name: /usr/local/bin/rfc.pl
    - pattern: '#! c:\perl\bin\perl.exe'
    - repl: '#!/usr/bin/env perl'
    - count: 1
    - watch:
      - file: sift-scripts-rfc
