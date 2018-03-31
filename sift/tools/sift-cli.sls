{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.5.2/sift-cli-linux" -%}
{%- set hash = "6ca93834139b5815e9a4f4c54cc709150e2062dbaea8897de05ea5d412af7e0c" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
