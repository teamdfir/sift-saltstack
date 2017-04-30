{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{{ user }}:
  user.present:
    - fullname: SANS Forensics
    - shell: /bin/bash
    - home: /home/sansforensics
    - password: $1$SZx86ctM$lcEicO1qXvwPG.lhXEvgd.
    - gid_from_name: True
