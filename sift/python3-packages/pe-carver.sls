# source=https://github.com/digitalsleuth/pe-carver
# license=apache2.0

include:
  - sift.python3-packages.core

sift-python3-package-pe-carver:
  pip.installed:
    - name: pe-carver
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.python3-packages.core
