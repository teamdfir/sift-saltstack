include:
  - sift.python3-packages.pip

sift-python3-packages-geoip2:
  pip.installed:
    - name: geoip2
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip
