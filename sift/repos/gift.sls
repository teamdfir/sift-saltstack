{%- set version = salt['pillar.get']('sift_version', 'stable') -%}
{%- set codename = grains['lsb_distrib_codename'] -%}

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

# Clean up legacy PPA format (both versions)
sift-gift-legacy-ppa-absent:
  pkgrepo.absent:
    - ppa: gift/{{ version }}
    - require_in:
      - pkgrepo: gift-repo

# Clean up DEB822 format (.sources files)
sift-gift-deb822-stable-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/gift-ubuntu-stable-{{ codename }}.sources
    - require_in:
      - pkgrepo: gift-repo

sift-gift-deb822-dev-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/gift-ubuntu-dev-{{ codename }}.sources
    - require_in:
      - pkgrepo: gift-repo

sift-gift-key:
  file.managed:
    - name: /usr/share/keyrings/GIFT-GPG-KEY.asc
    - source: https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3ED1EAECE81894B171D7DA5B5E80511B10C598B8
    - skip_verify: True
    - makedirs: True

gift-repo:
  pkgrepo.managed:
    - humanname: GIFT PPA ({{ version }})
    - name: deb [signed-by=/usr/share/keyrings/GIFT-GPG-KEY.asc] https://ppa.launchpadcontent.net/gift/{{ version }}/ubuntu {{ codename }} main
    - dist: {{ codename }}
    - file: /etc/apt/sources.list.d/gift-ubuntu-{{ version }}-{{ codename }}.list
    - refresh: True
    - clean_file: True
    - require:
      - file: sift-gift-key

sift-gift-repo-preferences:
  file.managed:
    - name: /etc/apt/preferences.d/gift
    - source: salt://sift/files/apt/gift.preferences
    - template: jinja
    - context:
        version: {{ version }}
