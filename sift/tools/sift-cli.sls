{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.5.1/sift-cli-linux" -%}
{%- set hash = "3847e734a98a842868ecc5488916e1273c8baf6d7a822c46d3f4079ec316566d" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
