{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- set all_users = salt['user.list_users']() -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = "/home/" + user -%}
{%- endif -%}
{%- if user in all_users -%}
sift-user-{{ user }}:
  user.present:
    - name: {{ user }}
    - home: {{ home }}
{%- else %}
sift-user-{{ user }}:
  user.present:
    - name: {{ user }}
    - fullname: SANS Forensics
    - shell: /bin/bash
    - home: {{ home }}
    - password: $6$7n5jpcUZ$oh6U9W9mWKbtgIcY8y4buQZR3XMBOU2xUi4xGH9kvcB9o4IIsFLZ/.ffhqqVI0gkVchcJf3RSLxQhpgwXgmBR/
    - usergroup: True
{%- endif %}
