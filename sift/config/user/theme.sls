{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}
{% set userid = (salt['user.info'](user))['uid'] %}

include:
  - sift.config.user.user
  - sift.packages.dbus-x11
  - sift.packages.libglib2-bin

sift-config-theme-set-background-directory:
  file.directory:
    - name: /usr/share/backgrounds
    - makedirs: True

sift-config-theme-set-background-file:
  file.managed:
    - name: /usr/share/backgrounds/sift.png
    - source: salt://sift/files/sift/images/sift.png
    - replace: True
    - require:
      - file: sift-config-theme-set-background-directory

sift-config-theme-manage-autostart:
  file.directory:
    - name: {{ home }}/.config/autostart/
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}

sift-config-theme-manage-gnome-terminal:
  file.managed:
    - name: {{ home }}/.config/autostart/gnome-terminal.desktop
    - source: salt://sift/files/sift/other/gnome-terminal.desktop
    - replace: True
    - require:
      - file: sift-config-theme-manage-autostart
      - user: sift-user-{{ user }}

sift-config-theme-set-background-file-gsettings:
  cmd.run:
    - names: 
      - gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/sift.png
      - gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
    {% if grains['oscodename'] == 'focal' %}
      - gsettings set org.gnome.shell favorite-apps "['gnome-terminal.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop']"
    {% elif grains['oscodename'] == 'jammy' %}
      - gsettings set org.gnome.shell favorite-apps "['gnome-terminal.desktop', 'firefox_firefox.desktop', 'org.gnome.Nautilus.desktop']"
      - gsettings set org.gnome.desktop.background picture-uri-dark file:///usr/share/backgrounds/sift.png
    {% endif %}
    - runas: {{ user }}
    - cwd: {{ home }}
    - shell: /bin/bash
    - env:
      - DBUS_SESSION_BUS_ADDRESS: 'unix:path=/run/user/{{ userid }}/bus'
    - require:
      - file: sift-config-theme-set-background-file
      - sls: sift.packages.libglib2-bin
      - sls: sift.packages.dbus-x11
