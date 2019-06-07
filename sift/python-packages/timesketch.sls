{%- set reinstall = salt['pillar.get']('python_force_reinstall', False) -%}
include:
  - sift.packages.python-pip
  - sift.packages.python-dev
  - sift.packages.libffi-dev

timesketch:
  pip.installed:
    {% if grains['oscodename'] == "bionic" -%}
    - pip_bin: /usr/bin/pip
    {% endif -%}
    - force_reinstall: {{ reinstall }}
    - require:
      - sls: sift.packages.python-pip
      - sls: sift.packages.python-dev
      - sls: sift.packages.libffi-dev