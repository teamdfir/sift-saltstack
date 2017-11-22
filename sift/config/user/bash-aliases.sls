{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - .user

sift-config-user-bash-aliases:
  file.managed:
    - name: /home/{{ user }}/.bash_aliases
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - user: sift-user-{{ user }}

sift-config-user-bash-aliases-user:
  file.append:
    - name: /home/{{ user }}/.bash_aliases
    - text: "alias mountwin='mount -o ro,loop,show_sys_files,streams_interface=windows'"
    - require:
      - file: sift-config-user-bash-aliases

sift-config-user-bash-aliases-user-root:
  file.append:
    - name: /root/.bash_aliases
    - text: "alias mountwin='mount -o ro,loop,show_sys_files,streams_interface=windows'"
