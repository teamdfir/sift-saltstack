{%- set version = salt['grains.get']('sift_version', 'stable') -%}

include:
  - ..packages.python-software-properties

{%- if version == "stable" %}
gift-dev:
  pkgrepo.absent:
    - ppa: gift/dev
{%- else %}
gift-stable:
  pkgrepo.absent:
    - ppa: gift/stable
{%- endif %}

gift:
  pkgrepo.managed:
    - name: gift
    - ppa: gift/{{ version }}
    - refresh_db: true
    - require:
      - pkg: python-software-properties
