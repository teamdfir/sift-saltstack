{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}
{%- set dbus_address = salt['cmd.run']("dbus-launch | grep DBUS_SESSION_BUS_ADDRESS | cut -d= -f2-", shell="/bin/bash", runas=user, cwd=home, python_shell=True) -%}

include:
  - sift.packages.dconf-cli

sift-config-terminal-profiles-file:
  file.managed:
    - name: /usr/share/sift/terminal-profiles.txt
    - source: salt://sift/config/user/files/terminal-profiles.txt
    - user: root
    - group: root
    - mode: 0644
    - makedirs: True

sift-config-terminal-profiles-install:
  cmd.run:
    - name: dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < /usr/share/sift/terminal-profiles.txt
    - runas: {{ user }}
    - cwd: {{ home }}
    - shell: /bin/bash
    - env:
      - DBUS_SESSION_BUS_ADDRESS: "{{ dbus_address }}"
    - require:
      - file: sift-config-terminal-profiles-file
      - sls: sift.packages.dconf-cli
    - watch:
      - file: sift-config-terminal-profiles-file

