{%- set version = salt['pillar.get']('sift_version', 'stable') -%}

include:
  - ..packages.python-software-properties

{%- if version == "stable" %}
sift-gift-dev:
  pkgrepo.absent:
    - ppa: gift/dev
    - require_in:
      - pkgrepo: sift-gift-repo
{%- else %}
sift-gift-stable:
  pkgrepo.absent:
    - ppa: gift/stable
    - require_in:
      - pkgrepo: sift-gift-repo
{%- endif %}

sift-gift-repo:
  pkgrepo.managed:
    - name: gift
    - ppa: gift/{{ version }}
    - refresh_db: true
    - require:
      - pkg: python-software-properties

sift-gift-repo-preferences:
  file.managed:
    - name: /etc/apt/preferences.d/gift
    - source: salt://sift/files/apt/gift.preferences
