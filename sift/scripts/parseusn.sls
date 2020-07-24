# source=https://github.com/superponible/DFIR/
# license=MIT

{% set commit = "ee681a07a0c32a5ccaea788cd7d012d19872f181" -%}
{% set hash = "sha256=4540eba4cdddcb0eab1bc21ccea6a6ab7c010936909bb233807dc9bf4189ab10" -%}

include:
  - sift.packages.python3

sift-scripts-parseusn:
  file.managed:
    - name: /usr/local/bin/parseusn.py
    - source: https://raw.githubusercontent.com/superponible/DFIR/{{ commit }}/parseusn.py
    - source_hash: {{ hash }}
    - mode: 755
