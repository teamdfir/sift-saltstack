{%- if grains['oscodename'] == "bionic" %}
{%- set commit="46ba76a73fcf71640f2a6e9db02afaaac3e178b9" -%}
include:
  - sift.packages.git
  - sift.packages.python3-pip

appcompatprocessor:
  pip.installed:
    - name: git+https://github.com/mbevilacqua/appcompatprocessor.git@{{ commit }}
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python3-pip
{%- else %}
sift-python-package-appcompatprocessor:
  test.nop
{%- endif %}