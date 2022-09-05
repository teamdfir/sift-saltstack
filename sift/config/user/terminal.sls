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

sift-config-terminal-profiles-file:
  file.managed:
    - name: /usr/share/sift/terminal-profiles.txt
    - source: salt://sift/config/user/files/terminal-profiles.txt
    - user: root
    - group: root
    - mode: 0644
    - makedirs: True

{% if grains['oscodename'] != "jammy" %}

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
    - watch:
      - file: sift-config-terminal-profiles-file

{% else %}

sift-config-terminal-profiles-jammy-script:
  file.managed:
    - name: {{ home }}/.config/terminal.sh
    - contents: |
        #!/bin/bash
        export DBUS_SESSION_BUS_ADDRESS=$(dbus-launch | grep DBUS_SESSION_BUS_ADDRESS | cut -d= -f2-)
        dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < /usr/share/sift/terminal-profiles.txt
    - makedirs: True
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - sls: sift.packages.dbus-x11
      - user: sift-user-{{ user }}

sift-config-terminal-profiles-jammy:
  cmd.run:
    - name: {{ home }}/.config/terminal.sh
    - runas: {{ user }}
    - shell: /bin/bash
    - cwd: {{ home }}
    - require:
      - file: sift-config-terminal-profiles-jammy-script
      - user: sift-user-{{ user }}
    - watch:
      - file: sift-config-terminal-profiles-jammy-script
      - user: sift-user-{{ user }}

{% endif %}
