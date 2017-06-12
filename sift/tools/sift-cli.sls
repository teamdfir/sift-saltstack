{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.2.5/sift-cli-linux" -%}
{%- set hash = "f9386d660ed27c396fd6228086b17b05f630d57ed2f8060650e5a078c529e9a6" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
