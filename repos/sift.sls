{%- set version = salt['pillar.get']('sift_version', 'stable') -%}

include:
  - sift.packages.software-properties-common

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
    - keyid: 3E04D0A9A043FAFD66F5E774B2A668DD0744BEC3
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - refresh: true
    - require:
      - sls: sift.packages.software-properties-common

sift-repo-preferences:
  file.managed:
    - name: /etc/apt/preferences.d/sift
    - source: salt://sift/files/apt/sift.preferences
    - template: jinja
    - context:
        version: {{ version }}
