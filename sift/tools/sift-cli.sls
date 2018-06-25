{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.7.0/sift-cli-linux" -%}
{%- set hash = "d48a70360d28fc0500a3a1a72cb06d8038273132c5cb51e710e1187a43eb27c1" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
