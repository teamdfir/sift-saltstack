{%- set commit = "d7c517af9f3b09b810c5859ee52a6540f3b25855" -%}
{%- set shasum = "61e75e485c0efc862e7b1c7746a493ca944afcf3e96512fb864706089f89d9aa" -%}
include:
  - sift.python-packages.python-registry

# Source: https://github.com/kevthehermit/Scripts
sift-scripts-shim-cache-parser:
  file.managed:
    - name: /usr/local/bin/ShimCacheParser.py
    - source: https://raw.githubusercontent.com/mandiant/ShimCacheParser/{{ commit }}/ShimCacheParser.py
    - source_hash: sha256={{ shasum }}
    - mode: 755
    - require:
      - sls: sift.python-packages.python-registry
