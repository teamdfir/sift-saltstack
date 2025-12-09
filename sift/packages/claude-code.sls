{%- set version = "2.0.61" -%}
{%- set base_url = "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases" -%}
{%- set hash = "5c5686e99180eb0bd0498564e1fa991aa05c4199a08222a15c1563626332e8fc" -%}
{%- set platform = "linux-x64" -%}
{%- if grains["osarch"] == "aarch64" or grains["osarch"] == "arm64" -%}
{%- set hash = "eb5414c3c73bb4a2d7c99a2e9005f3e0930887e06661c0d70bf3be9ab877f68e" -%}
{%- set platform = "linux-arm64" -%}
{%- endif -%}

sift-package-claude-code:
  file.managed:
    - name: /usr/local/bin/claude
    - source: "{{ base_url }}/{{ version }}/{{ platform }}/claude"
    - source_hash: sha256={{ hash }}
    - mode: 0755
    - keep_source: True
    - makedirs: True
