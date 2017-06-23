{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - .user

symlinks-user-desktop-directory:
  file.directory:
    - name: /home/{{ user }}/Desktop
    - require:
      - user: sift-user-{{ user }}

symlinks-mount-points:
  file.symlink:
    - name: /home/{{ user }}/Desktop/mount_points
    - target: /mnt
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - file: symlinks-user-desktop-directory
      - user: sift-user-{{ user }}

symlinks-cases:
  file.symlink:
    - name: /home/{{ user }}/Desktop/cases
    - target: /cases
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - file: symlinks-user-desktop-directory
      - user: sift-user-{{ user }}
