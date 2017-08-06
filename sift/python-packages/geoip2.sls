include:
  - sift.packages.python-pip

sift-pip-geoip2:
  pip.installed:
    - name: geoip2
    - require:
      - sls: sift.packages.python-pip
