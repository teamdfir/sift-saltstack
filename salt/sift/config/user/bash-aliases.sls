{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

/home/{{ user }}/.bash_aliases:
  file.append:
    - text: "alias mountwin='mount -o ro,loop,show_sys_files,streams_interface=windows'"

/root/.bash_aliases:
  file.append:
    - text: "alias mountwin='mount -o ro,loop,show_sys_files,streams_interface=windows'"
