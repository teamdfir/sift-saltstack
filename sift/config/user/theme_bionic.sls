{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- set dbus_address = salt['cmd.run']("dbus-launch | grep DBUS_SESSION_BUS_ADDRESS | cut -d= -f2-", shell="/bin/bash", runas=user, cwd="/home/" + user, python_shell=True) -%}

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
      - DBUS_SESSION_BUS_ADDRESS: "{{ dbus_address }}"
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
    - name: gsettings set org.gnome.shell favorite-apps "['gnome-terminal.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop']"
    - runas: {{ user }}
    - cwd: /home/{{ user }}
    - shell: /bin/bash
    - require:
      - user: sift-user-{{ user }}

sift-config-theme-gnome-launcher-position:
  cmd.run:
    - name: gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
    - runas: {{ user }}
    - cwd: /home/{{ user }}
    - shell: /bin/bash
    - require:
      - user: sift-user-{{ user }}

