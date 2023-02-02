{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}

include:
  - sift.config.user.user

folders-config-autostart:
  file.directory:
    - name: {{ home }}/.config/autostart
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True
    - require:
      - user: sift-user-{{ user }}
