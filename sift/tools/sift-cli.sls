{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.2.4/sift-cli-linux" -%}
{%- set hash = "3bb9ba80c90442d5e0b156f52ea072bc41615dccc5858e8bc9c3b01c92665af1" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
