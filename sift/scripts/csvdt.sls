# Name: csvdt
# Website: https://github.com/YardQuit/csvdt
# Description: Parse and normalise CSV on the command line, converting timestamps
#              between epoch, ISO 8601 and Windows FILETIME forms and localising
#              them to a time zone.
# Category:
# Author: YardQuit
# License: GPL-3.0-or-later
# Notes: csvdt
#
# Upstream publishes one statically linked musl binary for Linux, x86-64 only, so
# this state is guarded to amd64. Drop the guard once an aarch64-unknown-linux-musl
# asset ships. Pinned to the version's own tag rather than the rolling 'release'
# tag: that one is rebuilt monthly against a newer tzdata, so its checksum moves.
# The published names carry a target triple; the installed command is 'csvdt'.
{# no leading '-' on the version tag below: it would strip the newline above and
   splice the last comment line onto the state ID, commenting the state out. #}
{# renovate: datasource=github-release-attachments depName=YardQuit/csvdt #}
{% set version = "1.0.0" -%}
{%- set hash = "a0ca7d2ebf0493394ad5aeb279aa0c4a812fae7449b976fdcb24cac4b1f7f28c" -%}
{%- set base_url = "https://github.com/YardQuit/csvdt/releases/download" -%}

sift-scripts-csvdt:
  file.managed:
    - name: /usr/local/bin/csvdt
    - source: "{{ base_url }}/{{ version }}/csvdt-x86_64-unknown-linux-musl"
    - source_hash: sha256={{ hash }}
    - mode: 0755
    - makedirs: True
    - keep_source: True
    - onlyif:
      - fun: match.grain
        tgt: 'osarch:amd64'

sift-scripts-csvdt-mandir:
  file.directory:
    - name: /usr/local/share/man/man1
    - makedirs: True

# csvdt renders its own manual page from the same definitions that parse its
# options, so the page cannot drift from the binary that answers the commands.
# mandb is tolerated as absent -- man-db rescans the manpath without it.
sift-scripts-csvdt-man:
  cmd.run:
    - name: /usr/local/bin/csvdt --generate-man > /usr/local/share/man/man1/csvdt.1 && (mandb -q || true)
    - onchanges:
      - file: sift-scripts-csvdt
    - require:
      - file: sift-scripts-csvdt-mandir
