{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.6.1/sift-cli-linux" -%}
{%- set hash = "cc60b161f55684dbe76a3d8225511a95abdce8bcbc886ef9df266c7f2d9ad599" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
