{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.2.2/sift-cli-linux" -%}
{%- set hash = "807d7f7d4af165fd5358c4c86a0139dcb2fb7cb79838a41039171e3c2feefbe4" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
