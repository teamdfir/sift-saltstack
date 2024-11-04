include:
  - sift.python3-packages.core

sift-python3-packages-virustotal-api:
  pip.installed:
    - name: virustotal-api
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.core
