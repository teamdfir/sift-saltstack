{%- set version = salt['grains.get']('sift_version', 'stable') -%}
{%- if version == "stable" %}
sift-dev:
  pkgrepo.absent:
    - ppa: sift/dev
{%- else %}
sift-stable:
  pkgrepo.absent:
    - ppa: sift/stable
{%- endif %}

sift:
  pkgrepo.managed:
    - ppa: sift/{{ version }}
    - refresh_db: true
