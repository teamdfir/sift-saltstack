# source=https://github.com/williballenthin/python-registry
# license=apache2
# license_source=https://github.com/williballenthin/python-registry/blob/master/LICENSE.TXT

{% set commit = "62d8ae4ed1ca276f2a1ffe251e1750d10538ae52" -%}
{% set hash = "sha256=590fb825df2d17f2e83fcbf1a578f39d8c7bd38017d85edfb250c0fb92db8b3a" -%}

include:
  - sift.packages.bulk-extractor
  - sift.python-packages.volatility

sift-scripts-vshot:
  file.managed:
    - name: /usr/local/bin/vshot
    - source: https://raw.githubusercontent.com/CrowdStrike/Forensics/{{ commit }}/vshot
    - source_hash: {{ hash }}
    - mode: 755
    - require:
      - sls: sift.python-packages.volatility
      - sls: sift.packages.bulk-extractor
