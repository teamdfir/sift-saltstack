{%- set commit="64c71d7c8905a119b7abdf9813e6ef5f11d3ccf1" -%}
include:
  - sift.packages.git
  - sift.packages.python-pip

analyzemft:
  pip.installed:
    - name: git+https://github.com/dkovar/analyzeMFT.git@{{ commit }}
    {% if grains['oscodename'] == "bionic" -%}
    - pip_bin: /usr/bin/pip
    {% endif -%}
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python-pip
