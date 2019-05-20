{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- set dbus = salt['cmd.run']("ps -u " + user + " e | grep -Eo 'dbus-daemon.*address=unix:abstract=/tmp/dbus-[A-Za-z0-9]{10}' | tail -c35", shell="/bin/bash", runas="root", cwd="/root", python_shell=True) -%}

include:
  - sift.config.user.user

sift-config-theme-set-background-directory:
  file.directory:
    - name: /usr/share/backgrounds
    - makedirs: True

sift-config-theme-set-background-file:
  file.managed:
    - name: /usr/share/backgrounds/forensics_blue.jpg
    - source: salt://sift/files/sift/images/forensics_blue.jpg
    - replace: True
    - require:
      - file: sift-config-theme-set-background-directory

sift-config-theme-set-background-file-gsettings:
  cmd.run:
    - name: gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/forensics_blue.jpg
    - runas: {{ user }}
    - cwd: /home/{{ user }}
    - shell: /bin/bash
    - env:
      - DBUS_SESSION_BUS_ADDRESS: "{{ dbus }}"
    - require:
      - file: sift-config-theme-set-background-file

sift-config-theme-manage-autostart:
  file.directory:
    - name: /home/{{ user }}/.config/autostart/
    - makedirs: True

sift-config-theme-manage-gnome-terminal:
  file.managed:
    - name: /home/{{ user }}/.config/autostart/gnome-terminal.desktop
    - source: salt://sift/files/sift/other/gnome-terminal.desktop
    - replace: True
    - require:
      - file: sift-config-theme-manage-autostart
      - user: sift-user-{{ user }}

sift-config-theme-gnome-shell-favorites:
  cmd.run:
    - name: gsettings set org.gnome.shell favorite-apps ['gnome-terminal.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop']
    - runas: {{ user }}
    - cwd: /home/{{ user }}
    - shell: /bin/bash
    - env:
