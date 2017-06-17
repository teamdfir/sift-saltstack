{%- set commit = "5a0705d5beca09eab2fd5a47a52240dbc0db5bc9" -%}
{%- set hash = "cc643ae2ccd7b772f6d8a2abaa0e9dd33514c60328c5bc3b7d60bb69398b9637" -%}
# Source: https://github.com/woanware/usbdeviceforensics
# License: Unknown
sift-scripts-usbdeviceforensics:
  file.managed:
    - name: /usr/local/bin/usbdeviceforensics.py
    - source: https://raw.githubusercontent.com/woanware/usbdeviceforensics/{{ commit }}/usbdeviceforensics.py
    - source_hash: sha256={{ hash }}
    - mode: 755

sift-scripts-usbdeviceforensics-shebang:
  file.replace:
    - name: /usr/local/bin/usbdeviceforensics.py
    - pattern: '#!/usr/bin/python'
    - repl: '#!/usr/bin/env python'
    - count: 1
    - watch:
      - file: sift-scripts-usbdeviceforensics
