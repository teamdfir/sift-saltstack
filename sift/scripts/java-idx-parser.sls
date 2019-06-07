# source=https://github.com/Rurik/Java_IDX_Parser
# license=apache2.0
# license_source=https://github.com/Rurik/Java_IDX_Parser#copyright-and-license

{% set commit = "f9b7a3aeb66a86e891e28d5e762483dff5e15851" -%}
{% set hash = "sha256=963d5f38b93016f147295ab6871dcba326c9315ea9402652745ae6290b594f45" -%}

scripts-java-idx-parser:
  file.managed:
    - name: /usr/local/bin/idx_parser.py
    - source: https://raw.githubusercontent.com/Rurik/Java_IDX_Parser/{{ commit }}/idx_parser.py
    - source_hash: {{ hash }}
    - mode: 755
