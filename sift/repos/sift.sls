{%- set version = salt['pillar.get']('sift_version', 'stable') -%}
{%- set codename = grains['lsb_distrib_codename'] -%}

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

# Clean up legacy PPA format (both versions)
sift-legacy-ppa-absent:
  pkgrepo.absent:
    - ppa: sift/{{ version }}
    - require_in:
      - pkgrepo: sift-repo

# Clean up DEB822 format (.sources files)
sift-deb822-stable-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/sift-ubuntu-stable-{{ codename }}.sources
    - require_in:
      - pkgrepo: sift-repo

sift-deb822-dev-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/sift-ubuntu-dev-{{ codename }}.sources
    - require_in:
      - pkgrepo: sift-repo

sift-repo-key:
  file.managed:
    - name: /usr/share/keyrings/SIFT-GPG-KEY.asc
    - source: https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x93465001dc4c8a3fcbbcfe263a43288ee0ab26fb
    - skip_verify: True
    - makedirs: True

sift-repo:
  pkgrepo.managed:
    - humanname: SIFT PPA ({{ version }})
    - name: deb [signed-by=/usr/share/keyrings/SIFT-GPG-KEY.asc] https://ppa.launchpadcontent.net/sift/{{ version }}/ubuntu {{ codename }} main
    - dist: {{ codename }}
    - file: /etc/apt/sources.list.d/sift-{{ version }}-{{ codename }}.list
    - refresh: True
    - clean_file: True
    - require:
      - file: sift-repo-key

sift-repo-preferences:
  file.managed:
    - name: /etc/apt/preferences.d/sift
    - source: salt://sift/files/apt/sift.preferences
    - template: jinja
    - context:
        version: {{ version }}
