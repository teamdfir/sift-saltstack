{%- set commit = "03a0d9126359c6b4b0b508062d3422bea9b69036" -%}
{%- set hash = "1065c23fdea1fde90e931bf5ccabc93b508bee0f6855a6ef2b3b9fd74495e279" -%}
# Source: https://github.com/gleeda/misc-scripts
# License: GNU GPL
sift-scripts-jobparser:
  file.managed:
    - name: /usr/local/bin/jobparser.py
    - source: https://raw.githubusercontent.com/gleeda/misc-scripts/{{ commit }}/misc_python/jobparser.py
    - source_hash: sha256={{ hash }}
    - mode: 755
