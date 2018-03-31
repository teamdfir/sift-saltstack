{%- set commit="46ba76a73fcf71640f2a6e9db02afaaac3e178b9" -%}
include:
  - sift.packages.git
  - sift.packages.python-pip

appcompatprocessor:
  pip.installed:
    - name: git+https://github.com/mbevilacqua/appcompatprocessor.git@{{ commit }}
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python-pip
