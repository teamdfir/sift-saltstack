{%- set commit="64c71d7c8905a119b7abdf9813e6ef5f11d3ccf1" -%}
include:
  - sift.packages.git
  - sift.packages.python3-pip
  - sift.packages.python2-pip

analyzemft:
  pip.installed:
    - name: git+https://github.com/dkovar/analyzeMFT.git@{{ commit }}
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python2-pip
