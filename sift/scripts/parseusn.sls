{%- set commit = "master" -%}
{%- set hash = "4540eba4cdddcb0eab1bc21ccea6a6ab7c010936909bb233807dc9bf4189ab10" -%}
include:
  - sift.packages.python

# Source: https://github.com/superponible/DFIR/
# License: MIT Open Source License (http://opensource.org/licenses/mit-license.php)
sift-scripts-parseusn:
  file.managed:
    - name: /usr/local/bin/parseusn.py
    - source: https://raw.githubusercontent.com/superponible/DFIR/{{ commit }}/parseusn.py
    - source_hash: sha256={{ hash }}
    - mode: 755
