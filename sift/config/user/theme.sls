{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}
{%- set dbus_address = salt['cmd.run']("dbus-launch | grep DBUS_SESSION_BUS_ADDRESS | cut -d= -f2-", shell="/bin/bash", runas=user, cwd=home, python_shell=True) -%}

include:
  - sift.config.user.user
  {% if grains['oscodename'] == "jammy" %}
  - sift.packages.dbus-x11
  {% endif %}

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

{% if grains['oscodename'] != "jammy" %}

sift-config-theme-set-background-file-gsettings:
  cmd.run:
    - name: gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/sift.png
    - runas: {{ user }}
    - cwd: {{ home }}
    - shell: /bin/bash
    - env:
      - DBUS_SESSION_BUS_ADDRESS: "{{ dbus_address }}"
    - require:
      - file: sift-config-theme-set-background-file

{% else %}


sift-config-background-jammy-script:
  file.managed:
    - name: {{ home }}/.config/background.sh
    - contents: |
        #!/bin/bash
        export DBUS_SESSION_BUS_ADDRESS=$(dbus-launch | grep DBUS_SESSION_BUS_ADDRESS | cut -d= -f2-)
        gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/sift.png
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - sls: sift.packages.dbus-x11

sift-config-background-jammy:
  cmd.run:
    - name: {{ home }}/.config/background.sh
    - runas: {{ user }}
    - cwd: {{ home }}
    - shell: /bin/bash
    - require:
      - file: sift-config-background-jammy-script
      - user: sift-user-{{ user }}
    - watch:
      - file: sift-config-background-jammy-script

{% endif %}

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
