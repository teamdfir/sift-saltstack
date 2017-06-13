{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.4.0/sift-cli-linux" -%}
{%- set hash = "01a20988a19588f5a70408278452c3fe4a81f34504ec7e99536a95ac3ec55d9d" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
