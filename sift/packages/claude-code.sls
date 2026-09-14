# Name: Claude Code
# Website: https://docs.anthropic.com/en/docs/claude-code
# Description: Anthropic's agentic coding CLI; also the runtime several SIFT agent tools drive their skills and MCP servers through.
# Category:
# Author: Anthropic
# License: Proprietary (https://www.anthropic.com/legal/commercial-terms)
# Notes: claude
#
# Hosted off GitHub, and each release ships a per-arch binary with its own checksum, so
# the renovate custom manager cannot keep this current -- it captures one digest per file.
# Bump by hand: the channel markers at {base_url}/stable and /latest give the version, and
# the sha256 is of {base_url}/{version}/{platform}/claude.
{# no leading '-' on the next tag: it would strip the newline above and splice the last
   comment line onto the state ID below, commenting the whole state out. #}
{% set version = "2.1.224" -%}
{%- set base_url = "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases" -%}
{%- set hash = "a2b5add7dc4bcd8eaa029f4e8bdac4df7769b4073698db7989d206baf9419c2d" -%}
{%- set platform = "linux-x64" -%}
{%- if grains["osarch"] == "aarch64" or grains["osarch"] == "arm64" -%}
{%- set hash = "3e50836e227868746273653e0f8115cf5fc9cb34a081847c6040c81d80812c33" -%}
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
