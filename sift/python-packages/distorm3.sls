{%- if grains['oscodename'] == "bionic" %}
include:
  - sift.packages.python3-pip
  - sift.packages.python2-pip

sift-python-packages-distorm3:
  pip.installed:
    - name: distorm3 == 3.4.4
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip

{%- elif grains['oscodename'] == "focal" %}
include:
  - sift.packages.python3-pip
  - sift.packages.python2-pip
  - sift.packages.python2-dev

sift-python-packages-distorm3:
  pip.installed:
    - name: distorm3 == 3.4.4
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
      - sls: sift.packages.python2-dev

{%- endif %}
