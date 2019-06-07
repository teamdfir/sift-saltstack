{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
  
sift-config-terminal-profiles-file:
  file.managed:
    - name: /usr/share/sift/terminal-profiles.txt
    - source: salt://sift/config/user/files/terminal-profiles_bionic.txt
    - user: root
    - group: root
    - mode: 0644
    - makedirs: True

sift-config-terminal-profiles-install:
  cmd.run:
    - name: dconf load /org/gnome/terminal/legacy/profiles:/ < /usr/share/sift/terminal-profiles.txt
    - runas: {{ user }}
    - cwd: /home/{{ user }}
    - shell: /bin/bash
    - require:
      - file: sift-config-terminal-profiles-file
    - watch:
      - file: sift-config-terminal-profiles-file
