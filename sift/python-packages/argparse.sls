include:
  - sift.packages.python3-pip

sift-python-package-argparse:
  pip.installed:
    - name: argparse
    - require:
      - pkg: python3-pip
