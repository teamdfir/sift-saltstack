{%- set commit = "031d06d13189fdb8bd24b75585951b1b5b33aa56" -%}
{%- set hash = "909d835fbdf72e2bb582ef848455d92533b7297caef8f8de979420b53125956f" -%}
# Source: https://github.com/keydet89/Tools
# License: Not Specified
sift-scripts-usnj:
  file.managed:
    - name: /usr/local/bin/usnj.pl
    - source: https://raw.githubusercontent.com/keydet89/Tools/{{ commit }}/source/usnj.pl
    - source_hash: sha256={{ hash }}
    - mode: 755

sift-scripts-usnj-shebang:
  file.replace:
    - name: /usr/local/bin/usnj.pl
    - pattern: '#! c:\perl\bin\perl.exe'
    - repl: '#!/usr/bin/env perl'
    - count: 1
    - watch:
      - file: sift-scripts-usnj
