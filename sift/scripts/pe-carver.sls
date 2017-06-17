{%- set commit = "9026cd2ca4bd0633f9898a93cb798cd19cffc8f6" -%}
{%- set hash = "6b245decadde4652ff6d1e2b24f6496dd252bee4bf57e7c934fbb9c9f21df849" -%}
include:
  - sift.python-packages.bitstring
  - sift.python-packages.pefile

# Source: https://github.com/Rurik/PE_Carver
# License: No Specified
sift-scripts-pecarve:
  file.managed:
    - name: /usr/local/bin/pecarve.py
    - source: https://raw.githubusercontent.com/Rurik/PE_Carver/{{ commit }}/pe_carve.py
    - source_hash: sha256={{ hash }}
    - mode: 755
    - require:
      - sls: sift.python-packages.bitstring
      - sls: sift.python-packages.pefile

sift-scripts-pecarve-shebang:
  file.prepend:
    - name: /usr/local/bin/pecarve.py
    - text: '#!/usr/bin/env python'
    - watch:
      - file: sift-scripts-pecarve
