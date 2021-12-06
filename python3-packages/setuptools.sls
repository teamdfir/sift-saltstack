include:
  - sift.python3-packages.pip

sift-python3-packages-setuptools:
  pip.installed:
    - name: setuptools
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip
