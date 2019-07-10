{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}

include:
  - sift.python-packages.rekall
  - sift.config.user.user

sift-config-user-rekall-rc:
  file.managed:
    - name: {{ home }}/.rekallrc
    - source: salt://sift/config/user/files/rekall-profile.txt
    - user: {{ user }}
    - group: {{ user }}
    - backup: True
    - replace: False
    - require:
      - user: sift-user-{{ user }}
      - sls: sift.python-packages.rekall
