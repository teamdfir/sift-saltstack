{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- set dbus_address = salt['cmd.run']("dbus-launch | grep DBUS_SESSION_BUS_ADDRESS | cut -d= -f2-", shell="/bin/bash", runas=user, cwd="/home/" + user, python_shell=True) -%}

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
    - name: dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < /usr/share/sift/terminal-profiles.txt
    - runas: {{ user }}
    - cwd: /home/{{ user }}
    - shell: /bin/bash
    - env:
      - DBUS_SESSION_BUS_ADDRESS: "{{ dbus_address }}"
    - require:
      - file: sift-config-terminal-profiles-file
    - watch:
      - file: sift-config-terminal-profiles-file
