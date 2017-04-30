{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - .user

bash-aliases-user-{{ user }}:
  file.append:
    - name: /home/{{ user }}/.bash_aliases
    - text: "alias mountwin='mount -o ro,loop,show_sys_files,streams_interface=windows'"
    - require:
      - user: {{ user }}

bash-aliases-user-root:
  file.append:
    - name: /root/.bash_aliases
    - text: "alias mountwin='mount -o ro,loop,show_sys_files,streams_interface=windows'"
    - require:
      - file: bash-aliases-user-{{ user }}
