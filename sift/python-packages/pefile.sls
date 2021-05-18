include:
  - sift.packages.python3-pip
  - sift.packages.python2-pip
  - sift.packages.git

sift-python-packages-pefile:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/pefile.git
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
      - sls: sift.packages.git
