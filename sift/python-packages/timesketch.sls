{%- set reinstall = salt['pillar.get']('python_force_reinstall', False) -%}
include:
  - sift.packages.python3-pip
  - sift.packages.python3-dev
  - sift.packages.libffi-dev

timesketch:
  pip.installed:
    - force_reinstall: {{ reinstall }}
    - require:
      - sls: sift.packages.python3-pip
      - sls: sift.packages.python3-dev
      - sls: sift.packages.libffi-dev