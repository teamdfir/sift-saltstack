{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - sift.python-packages.rekall
  - sift.config.user.user

sift-config-user-rekall-rc:
  file.managed:
    - name: /home/{{ user }}/.rekallrc
    - source: salt://sift/config/user/files/rekall-profile.txt
    - user: {{ user }}
    - group: {{ user }}
    - backup: True
    - replace: False
    - require:
      - user: sift-user-{{ user }}
      - sls: sift.python-packages.rekall
