{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.1.1/sift-cli-linux" -%}
{%- set hash = "f0f049839a0ed493d3417c12d4228f558c82984e78dbdd9054e052b44f21e9d2" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
