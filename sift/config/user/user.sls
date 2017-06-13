{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- set all_users = salt['user.list_users']() -%}
{%- if user in all_users -%}
{{ user }}:
  user.present:
    - home: /home/{{ user }}
{%- else %}
{{ user }}:
  user.present:
    - fullname: SANS Forensics
    - shell: /bin/bash
    - home: /home/{{ user }}
    - password: $6$7n5jpcUZ$oh6U9W9mWKbtgIcY8y4buQZR3XMBOU2xUi4xGH9kvcB9o4IIsFLZ/.ffhqqVI0gkVchcJf3RSLxQhpgwXgmBR/
    - gid_from_name: True
{%- endif %}
