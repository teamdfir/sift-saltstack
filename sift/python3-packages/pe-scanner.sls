# source=https://github.com/digitalsleuth/pe-scanner
# license=gplv3.0

include:
  - sift.python3-packages.core
  - sift.packages.git

sift-python3-package-pe-scanner:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/pe-scanner.git
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.python3-packages.core
      - sls: sift.packages.git
