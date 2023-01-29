{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}
{%- set dbus_address = salt['cmd.run']("dbus-launch | grep DBUS_SESSION_BUS_ADDRESS | cut -d= -f2-", shell="/bin/bash", runas=user, cwd=home, python_shell=True) -%}

include:
  - sift.config.user.user
  - sift.packages.dbus-x11
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
    - name: dconf load /org/gnome/terminal/legacy/profiles:/ < /usr/share/sift/terminal-profiles.txt
    - runas: {{ user }}
    - cwd: {{ home }}
    - shell: /bin/bash
{% if grains['oscodename'] == 'focal' %}
    - env:
      - DBUS_SESSION_BUS_ADDRESS: '{{ dbus_address }}'
{% endif %}
    - require:
      - file: sift-config-terminal-profiles-file
      - sls: sift.packages.dconf-cli
      - sls: sift.packages.dbus-x11
    - watch:
      - file: sift-config-terminal-profiles-file
