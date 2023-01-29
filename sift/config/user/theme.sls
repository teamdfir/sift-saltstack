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

{% if grains['oscodename'] == 'focal' %}

sift-config-theme-set-background-file-gsettings:
  cmd.run:
    - name: gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/sift.png
    - runas: {{ user }}
    - cwd: {{ home }}
    - shell: /bin/bash
    - env:
      - DBUS_SESSION_BUS_ADDRESS: '{{ dbus_address }}'
    - require:
      - file: sift-config-theme-set-background-file
      - sls: sift.packages.libglib2-bin
      - sls: sift.packages.dbus-x11

sift-config-theme-gnome-shell-favorites:
  cmd.run:
    - name: gsettings set org.gnome.shell favorite-apps "['gnome-terminal.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop']"
    - runas: {{ user }}
    - cwd: {{ home }}
    - shell: /bin/bash
    - require:
      - user: sift-user-{{ user }}

sift-config-theme-gnome-launcher-position:
  cmd.run:
    - name: gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
    - runas: {{ user }}
    - cwd: {{ home }}
    - shell: /bin/bash
    - require:
      - user: sift-user-{{ user }}

{% elif grains['oscodename'] == 'jammy' %}

sift-gnome-settings:
  file.managed:
    - name: {{ home }}/.config/sift-gnome-settings.sh
    - contents: |
        #!/bin/bash
        gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/sift.png
        gsettings set org.gnome.desktop.background picture-uri-dark file:///usr/share/backgrounds/sift.png
        gsettings set org.gnome.shell favorite-apps "['gnome-terminal.desktop', 'firefox_firefox.desktop', 'org.gnome.Nautilus.desktop']"
        gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
        mv {{ home }}/.config/autostart/sift-gnome-settings.destkop {{ home }}
    - mode: 755
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - user: sift-user-{{ user }}
      - sls: sift.packages.dbus-x11
      - sls: sift.packages.libglib2-bin
      - file: sift-config-theme-set-background-file

sift-gnome-settings-autostart:
  file.managed:
    - name: {{ home }}/.config/autostart/sift-gnome-settings.desktop
    - contents: |
        [Desktop Entry]
        Type=Application
        Name=sift-gnome-settings
        Comment=Bash script to apply SIFT configuration on start
        Exec={{ home }}/.config/sift-gnome-settings.sh
        Categories=System;
    - mode: 755
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - file: sift-gnome-settings

{% endif %}
