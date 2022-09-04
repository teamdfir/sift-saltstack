{%- set version = salt['pillar.get']('sift_version', 'stable') -%}

include:
  - sift.packages.software-properties-common

{%- if version == "stable" %}
sift-gift-dev:
  pkgrepo.absent:
    - ppa: gift/dev
    - require_in:
      - pkgrepo: gift-repo
{%- else %}
sift-gift-stable:
  pkgrepo.absent:
    - ppa: gift/stable
    - require_in:
      - pkgrepo: gift-repo
{%- endif %}

gift-repo:
  pkgrepo.managed:
    - name: gift
    - ppa: gift/{{ version }}
    - keyid: 3ED1EAECE81894B171D7DA5B5E80511B10C598B8
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - refresh: true
    - require:
      - sls: sift.packages.software-properties-common

sift-gift-repo-preferences:
  file.managed:
    - name: /etc/apt/preferences.d/gift
    - source: salt://sift/files/apt/gift.preferences
    - template: jinja
    - context:
        version: {{ version }}
