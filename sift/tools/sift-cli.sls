{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.0.0/sift-cli-linux" -%}
{%- set hash = "175385c46ef77eea538d5f38d3e3ce0d628a05acc9cd7d882e0b4583421fef95" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
