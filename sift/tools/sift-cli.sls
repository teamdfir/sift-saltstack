{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.2.3/sift-cli-linux" -%}
{%- set hash = "14aeadaa08b47d5188ae5be14ffef7ab93e6b8c95a4e46397d5ad06554097fdd" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
