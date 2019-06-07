include:
  - sift.packages.python-pip
  - sift.packages.python-pip

argparse:
  pip.installed:
    - name: argparse
    {% if grains['oscodename'] == "bionic" -%}
    - pip_bin: /usr/bin/pip
    {% endif -%}
    - require:
      - pkg: python-pip
