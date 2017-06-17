{%- set commit = "62d8ae4ed1ca276f2a1ffe251e1750d10538ae52" -%}
{%- set hash = "590fb825df2d17f2e83fcbf1a578f39d8c7bd38017d85edfb250c0fb92db8b3a" -%}
include:
  - sift.packages.bulk-extractor
  - sift.packages.python-volatility

# Source: https://github.com/williballenthin/python-registry
# License: Apache2 - https://github.com/williballenthin/python-registry/blob/master/LICENSE.TXT
sift-scripts-vshot:
  file.managed:
    - name: /usr/local/bin/vshot
    - source: https://raw.githubusercontent.com/CrowdStrike/Forensics/{{ commit }}/vshot
    - source_hash: sha256={{ hash }}
    - mode: 755
    - require:
      - pkg: python-volatility
      - pkg: bulk-extractor
