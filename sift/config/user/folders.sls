{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - .user

folders-config-autostart:
  file.directory:
    - name: /home/{{ user }}/.config/autostart
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True
    - require:
      - user: sift-user-{{ user }}
