include:
  - sift.packages.python3-pip

sift-python3-packages-geoip2:
  pip.installed:
    - name: geoip2
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
