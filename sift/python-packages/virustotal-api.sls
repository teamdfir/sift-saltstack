include:
  - sift.packages.python3-pip

sift-python-package-virustotal-api:
  pip.installed:
    - name: virustotal-api
    - require:
      - sls: sift.packages.python3-pip
