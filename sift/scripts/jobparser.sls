# source=https://github.com/gleeda/misc-scripts
# license=gplv2

{% set commit = "03a0d9126359c6b4b0b508062d3422bea9b69036" -%}
{% set hash = "sha256=a6869e7f0f2f360681ff67a67b65c627b0084ebec25d7a9bb44abe8a1cdfb467" -%}

sift-scripts-jobparser:
  file.managed:
    - name: /usr/local/bin/jobparser.py
    - source: https://raw.githubusercontent.com/gleeda/misc-scripts/{{ commit }}/misc_python/jobparser.py
    - source_hash: {{ hash }}
    - mode: 755
