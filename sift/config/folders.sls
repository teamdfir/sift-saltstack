{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
/cases:
  file.directory:
    - user: {{ user }}
    - group: root
    - makedirs: true
    - dir_mode: 775

{% for folder in ['usb','vss','shadow','windows_mount','e01','aff','ewf','bde','iscsi'] %}
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
/mnt/shadow/vss{{n}}:
  file.directory:
    - user: root
    - group: root
    - makedirs: true
{% endfor %}
