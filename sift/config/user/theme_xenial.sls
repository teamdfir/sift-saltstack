{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}
{%- set dbus = salt['cmd.run']("ps -u " + user + " e | grep -Eo 'dbus-daemon.*address=unix:abstract=/tmp/dbus-[A-Za-z0-9]{10}' | tail -c35", shell="/bin/bash", runas="root", cwd="/root", python_shell=True) -%}

include:
  - sift.config.user.user
  - sift.packages.arc-icons
  - sift.packages.arc-theme  

sift-config-theme-gtk:
  cmd.run:
    - name: gsettings set org.gnome.desktop.interface gtk-theme Arc
    - runas: {{ user }}
    - cwd: {{ home }}
    - shell: /bin/bash
    - env:
      - DBUS_SESSION_BUS_ADDRESS: "{{ dbus }}"
    - require:
      - pkg: sift-package-arc-theme

sift-config-theme-icon:
  cmd.run:
    - name: gsettings set org.gnome.desktop.interface icon-theme Arc-Icons
    - runas: {{ user }}
    - cwd: {{ home }}
    - shell: /bin/bash
    - env:
      - DBUS_SESSION_BUS_ADDRESS: "{{ dbus }}"
    - require:
      - pkg: sift-package-arc-icons

sift-config-theme-set-background-directory:
  file.directory:
    - name: /usr/share/backgrounds
    - makedirs: True

sift-config-theme-set-background:
  file.managed:
    - name: /usr/share/backgrounds/warty-final-ubuntu.png
    - source: salt://sift/files/sift/images/forensics_blue.jpg
    - replace: True
    - require:
      - file: sift-config-theme-set-background-directory
      - user: sift-user-{{ user }}

sift-config-theme-manage-autostart:
  file.directory:
    - name: {{ home }}/.config/autostart/
    - makedirs: True

sift-config-theme-manage-gnome-terminal:
  file.managed:
    - name: {{ home }}/.config/autostart/gnome-terminal.desktop
    - source: salt://sift/files/sift/other/gnome-terminal.desktop
    - replace: True
    - require:
      - file: sift-config-theme-manage-autostart
      - user: sift-user-{{ user }}
