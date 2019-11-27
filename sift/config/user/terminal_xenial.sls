{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}
{%- set dbus = salt['cmd.run']("ps -u " + user + " e | grep -Eo 'dbus-daemon.*address=unix:abstract=/tmp/dbus-[A-Za-z0-9]{10}' | tail -c35", shell="/bin/bash", runas="root", cwd="/root", python_shell=True) -%}
  
sift-config-terminal-profiles-file:
  file.managed:
    - name: /usr/share/sift/terminal-profiles.txt
    - source: salt://sift/config/user/files/terminal-profiles_xenial.txt
    - user: root
    - group: root
    - makedirs: True

sift-config-terminal-profiles-install:
  cmd.run:
    - name: dconf load /org/gnome/terminal/ < /usr/share/sift/terminal-profiles.txt
    - runas: {{ user }}
    - cwd: {{ home }}
    - shell: /bin/bash
    - env:
      - DBUS_SESSION_BUS_ADDRESS: "{{ dbus }}"
    - watch:
      - file: sift-config-terminal-profiles-file
