include:
  - sift.packages.python2-pip
  - sift.packages.python3-pip

sift-python-packages-pillow:
  pip.installed:
    - name: pillow
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
