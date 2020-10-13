include:
  - sift.packages.python3-pip

sift-python3-packages-virustotal-api:
  pip.installed:
    - name: virustotal-api
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
