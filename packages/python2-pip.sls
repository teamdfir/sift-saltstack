include:
  - sift.packages.python2
  - sift.packages.curl

sift-package-python2-pip-install-script:
  cmd.run:
    - name: curl -o /tmp/get-pip.py https://bootstrap.pypa.io/pip/2.7/get-pip.py 
    - unless: which pip2
    - require:
      - sls: sift.packages.python2
      - sls: sift.packages.curl

sift-package-python2-pip-install:
  cmd.run:
    - name: python2 /tmp/get-pip.py
    - unless: which pip2
    - require:
      - cmd: sift-package-python2-pip-install-script
