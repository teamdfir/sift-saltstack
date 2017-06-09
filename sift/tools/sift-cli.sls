{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.1.0/sift-cli-linux" -%}
{%- set hash = "460b41a7811970a2fb742f4a7161bfcac594306dafba714eb79ff54a9314f5ed" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
