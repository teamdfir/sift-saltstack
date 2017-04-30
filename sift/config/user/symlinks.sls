{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - .user

symlinks-mount-points:
  file.symlink:
    - name: /home/{{ user }}/Desktop/mount_points
    - target: /mnt
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - user: {{ user }}

symlinks-cases:
  file.symlink:
    - name: /home/{{ user }}/Desktop/cases
    - target: /cases
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - user: {{ user }}
