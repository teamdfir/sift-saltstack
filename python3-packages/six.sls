include:
  - sift.python3-packages.pip

sift-python3-packages-six:
  pip.installed:
    - name: six
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip
