{% if grains['oscodename'] != "jammy" %}

{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- set commit = "ca08236b0f70798cb6f89785820c9b82ee0c66ff" -%}

include:
  - sift.packages.git
  - sift.packages.g++
  - sift.packages.libfuse-dev
  - sift.packages.pkg-config
  - sift.packages.python2-pip
  - sift.packages.python2-dev
  - sift.packages.python-wxgtk3
  - sift.python-packages.setuptools

sift-python-packages-indxparse:
  pip.installed:
    - name: git+https://github.com/williballenthin/INDXParse.git@{{ commit }}
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.g++
      - sls: sift.packages.pkg-config
      - sls: sift.packages.python2-pip
      - sls: sift.packages.python2-dev
      - sls: sift.packages.libfuse-dev
      - sls: sift.packages.python-wxgtk3
      - sls: sift.python-packages.setuptools

sift-python-packages-indxparse-shebang:
  file.prepend:
    - name: /usr/local/bin/INDXParse.py
    - text: '#!/usr/bin/env python2'
    - watch:
      - pip: sift-python-packages-indxparse

{% else %}
python-wxgtk3-not-in-jammy:
  test.nop

{% endif %}
