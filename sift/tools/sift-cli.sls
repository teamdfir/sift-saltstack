{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.3.0/sift-cli-linux" -%}
{%- set hash = "fb8c37daaf5fd5b91e5bf08291d84ce11f7f69a47579e2bc68f3367da249a56d" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
