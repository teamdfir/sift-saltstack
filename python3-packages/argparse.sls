include:
  - sift.python3-packages.pip

sift-python3-packages-argparse:
  pip.installed:
    - name: argparse
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip
