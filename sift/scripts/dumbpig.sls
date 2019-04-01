# source=https://github.com/leonward/dumbpig
# license=gpl

{%- set commit = "429a880e6fb8e1528e406bc962e23f16df5ca959" -%}
{%- set hash   = "cbb11d7a20556b8c645e71b0c3dc422b4e48c2f18dce719cf6504a4af516bf07" %}

sift-scripts-dumbpig:
  file.managed:
    - name: /usr/local/bin/dumbpig.pl
    - source: https://raw.githubusercontent.com/leonward/dumbpig/{{ commit }}/dumbpig.pl
    - source_hash: sha256={{ hash }}
    - mode: 755
