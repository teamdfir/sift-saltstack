include:
  - sift.packages.python3-pip

sift-python-package-geoip2:
  pip.installed:
    - name: geoip2
    - require:
      - sls: sift.packages.python3-pip
