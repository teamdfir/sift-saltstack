# license=gpl
# license_source=https://github.com/zrlram/afterglow/blob/master/afterglow.pl

{% set commit = "91e7dd3f1f7fb9ab3b68fbe47b31997d8f073c1c" %}
{% set hash = "95900e17f696d4020efc9f52399996badc9974aa084e593200a1a54c1a523a3f" %}

sift-scripts-afterglow:
  file.managed:
    - name: /usr/local/bin/afterglow.pl
    - source: https://raw.githubusercontent.com/zrlram/afterglow/{{ commit }}/afterglow.pl
    - source_hash: sha256={{ hash }}
    - mode: 755

sift-scripts-afterglow-shebang:
  file.replace:
    - name: /usr/local/bin/afterglow.pl
    - pattern: '#!/usr/bin/perl'
    - repl: '#!/usr/bin/env perl'
    - count: 1
    - watch:
      - file: sift-scripts-afterglow
