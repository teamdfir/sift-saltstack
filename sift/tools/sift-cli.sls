{%- set source = "https://github.com/sans-dfir/sift-cli/releases/download/v1.5.0-beta.0/sift-cli-linux" -%}
{%- set hash = "c50d7e39462e1f94791932aed5c7aec30d8059d24fdc87c7c6b3e830c7a7ccdf" -%}

sift-tool-sift-cli:
  file.managed:
    - name: /usr/local/bin/sift
    - source: {{ source }}
    - source_hash: sha256={{ hash }}
    - mode: 755
