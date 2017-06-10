{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.2.0/sift-cli-linux" -%}
{%- set hash = "fb966cbee800b5428a0444d361aee8fd785f1ac77933dba7b4336c5b5011c69e" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
