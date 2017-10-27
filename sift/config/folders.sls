{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - .user

config-folder-cases:
  file.directory:
    - name: /cases
    - user: {{ user }}
    - group: root
    - makedirs: true
    - dir_mode: 775
    - require:
      - user: sift-user-{{ user }}

{% for folder in ['usb','vss','shadow_mount','windows_mount','ewf_mount','e01','aff','ewf','bde','iscsi'] %}
/mnt/{{ folder }}:
  file.directory:
    - user: root
    - group: root
    - makedirs: true
{% endfor %}

{% for n in range(1, 6) %}
/mnt/windows_mount{{n}}:
  file.directory:
    - user: root
    - group: root
    - makedirs: true
{% endfor %}

{% for n in range(1, 31) %}
/mnt/shadow_mount/vss{{n}}:
  file.directory:
    - user: root
    - group: root
    - makedirs: true
{% endfor %}
