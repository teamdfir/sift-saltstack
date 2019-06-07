# source=https://github.com/kevthehermit/Scripts
# license=unknown

{% set commit = "28b3e08a5ad16576ffe487691376f3e2a2bc0cf5" -%}
{% set hash = "sha256=7e810482b5aa58f8085a7a03be266c113530145306c73c75ba9956ba83e39151" -%}

sift-scripts-image-mounter:
  file.managed:
    - name: /usr/local/bin/imageMounter.py
    - source: https://raw.githubusercontent.com/kevthehermit/Scripts/{{ commit }}/imageMounter.py
    - source_hash: {{ hash }}
    - mode: 755
