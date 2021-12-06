{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}

include:
  - .user

symlinks-user-desktop-directory:
  file.directory:
    - name: {{ home }}/Desktop
    - require:
      - user: sift-user-{{ user }}

symlinks-mount-points:
  file.symlink:
    - name: {{ home }}/Desktop/mount_points
    - target: /mnt
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - file: symlinks-user-desktop-directory
      - user: sift-user-{{ user }}

symlinks-cases:
  file.symlink:
    - name: {{ home }}/Desktop/cases
    - target: /cases
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - file: symlinks-user-desktop-directory
      - user: sift-user-{{ user }}
