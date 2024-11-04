{%- set commit="b1d0e6a0aa58d42000bfdb8e6588513bd62eaeab" -%}
include:
  - sift.packages.git
  - sift.packages.python2-pip
  - sift.python-packages.setuptools

analyzemft:
  pip.installed:
    - name: git+https://github.com/dkovar/analyzeMFT.git@{{ commit }}
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python2-pip
      - sls: sift.python-packages.setuptools
