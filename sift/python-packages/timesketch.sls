{%- set reinstall = salt['pillar.get']('python_force_reinstall', False) -%}
include:
  - ..packages.python-pip
  - ..packages.python-dev
  - ..packages.libffi-dev

timesketch:
  pip.installed:
    - force_reinstall: {{ reinstall }}
    - require:
      - pkg: python-pip
      - pkg: python-dev
      - pkg: libffi-dev
