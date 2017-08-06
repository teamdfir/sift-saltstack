include:
  - sift.packages.python-pip

sift-pip-virustotal-api:
  pip.installed:
    - name: virustotal-api
    - require:
      - sls: sift.packages.python-pip
