{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

/home/{{ user }}/Desktop/mount_points:
  file.symlink:
    - target: /mnt
    - user: {{ user }}
    - group: {{ user }}

/home/{{ user }}/Desktop/cases:
  file.symlink:
    - target: /cases
    - user: {{ user }}
    - group: {{ user }}
