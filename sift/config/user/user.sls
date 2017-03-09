{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- set all_users = salt['user.list_users']() -%}
{%- if '{{ user }}' in all_users -%}
{{ user }}:
  user.present:
    - home: /home/{{ user }}
{%- else -%}
{{ user }}:
  user.present:
    - fullname: SANS Forensics
    - shell: /bin/bash
    - home: /home/{{ user }}
    - password: $1$SZx86ctM$lcEicO1qXvwPG.lhXEvgd.
    - gid_from_name: True
{%- endif -%}
