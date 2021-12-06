{%- set commit="6c847937c5a836e2ce2fe2b915f213c345a3c389" -%}

{%- if grains['oscodename'] == "bionic" %}
include:
  - sift.packages.git
  - sift.packages.python3-pip
  - sift.packages.python2-pip
  - sift.packages.libregf

appcompatprocessor:
  pip.installed:
    - name: git+https://github.com/mbevilacqua/appcompatprocessor.git@{{ commit }}
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python2-pip
      - sls: sift.packages.libregf

{%- elif grains['oscodename'] == "focal" %}
include:
  - sift.packages.git
  - sift.packages.python3-pip
  - sift.packages.python2-pip
  - sift.packages.libregf
  - sift.packages.python2-dev

appcompatprocessor:
  pip.installed:
    - name: git+https://github.com/mbevilacqua/appcompatprocessor.git@{{ commit }}
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python2-pip
      - sls: sift.packages.libregf
      - sls: sift.packages.python2-dev

{%- endif %}
