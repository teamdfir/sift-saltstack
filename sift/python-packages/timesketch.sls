{%- set reinstall = salt['pillar.get']('python_force_reinstall', False) -%}

include:
  - sift.packages.python-dev
  - sift.packages.libffi-dev

timesketch:
  pip.installed:
    - force_reinstall: {{ reinstall }}
    - require:
      - pkg: libffi-dev
