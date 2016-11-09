{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

/home/{{ user }}/.config/autostart:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - makedirs: True
