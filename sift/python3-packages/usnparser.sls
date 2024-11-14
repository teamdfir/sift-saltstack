include:
  - sift.python3-packages.core

sift-python3-package-usnparser:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/USN-Journal-Parser.git
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.core
