{%- set version = salt['pillar.get']('sift_version', 'stable') -%}

include:
  - sift.packages.python-software-properties

{%- if version == "stable" %}
sift-dev:
  pkgrepo.absent:
    - ppa: sift/dev
    - require_in:
      - pkgrepo: sift-repo
{%- else %}
sift-stable:
  pkgrepo.absent:
    - ppa: sift/stable
    - require_in:
      - pkgrepo: sift-repo
{%- endif %}

sift-repo:
  pkgrepo.managed:
    - ppa: sift/{{ version }}
    - refresh_db: true
    - require:
      - pkg: python-software-properties
