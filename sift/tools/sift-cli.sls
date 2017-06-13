{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.4.0/sift-cli-linux" -%}
{%- set hash = "3199c559c034fd8c3f33a0a6d05e142288303476b69bd08e74b2ba0930b4e528" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
