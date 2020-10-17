include:
  - sift.packages.python3-pip

sift-python-packages-pillow:
  pip.installed:
    - name: pillow
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip
