{%- set commit="6c847937c5a836e2ce2fe2b915f213c345a3c389" -%}

include:
  - sift.packages.git
  - sift.packages.python2-pip
  - sift.packages.libregf

appcompatprocessor:
  pip.installed:
    - name: git+https://github.com/mbevilacqua/appcompatprocessor.git@{{ commit }}
    - bin_env: /usr/bin/pip2
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python2-pip
      - sls: sift.packages.libregf
