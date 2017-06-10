{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.2.1/sift-cli-linux" -%}
{%- set hash = "9d12ffdb590cf84d3ed821c317bbe124b112b8c636a7a54d303cc78908d302db" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
