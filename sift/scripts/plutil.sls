{%- set commit = "b830f58fe53958c54def0ec66d0617f9cf5c60d9" -%}
{%- set hash = "a1db4dccfa54a41361d11273dfdd88c59b4caca60f4d58e672cc867393a72166" -%}
include:
  - sift.packages.libencode-perl

# Source: https://github.com/HearthSim/extract-scripts
# License: Unknown
sift-scripts-plutil:
  file.managed:
    - name: /usr/local/src/scripts/plutil.pl
    - source: https://raw.githubusercontent.com/HearthSim/extract-scripts/master/plutil.pl
    - source_hash: sha256={{ hash }}
    - makedirs: True
    - require:
      - sls: sift.packages.libencode-perl

sift-scripts-plutil-binary:
  file.copy:
    - name: /usr/local/bin/plutil.pl
    - source: /usr/local/src/scripts/plutil.pl
    - mode: 755
    - watch: 
      - file: sift-scripts-plutil

sift-scripts-plutil-shebang:
  file.replace:
    - name: /usr/local/bin/plutil.pl
    - pattern: '#!/usr/bin/perl'
    - repl: '#!/usr/bin/env perl'
    - count: 1
    - watch:
      - file: sift-scripts-plutil-binary
