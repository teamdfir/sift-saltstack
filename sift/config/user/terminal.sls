{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}

include:
  - sift.packages.dconf-cli
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
    - onlyif:
      - fun: cmd.run
        cmd: export DBUS_SESSION_BUS_ADDRESS=$(dbus-launch | grep DBUS_SESSION_BUS_ADDRESS | cut -d= -f2-)
        shell: /bin/bash
        python_shell: True
        runas: {{ user }}
    - require:
      - file: sift-config-terminal-profiles-file
      - sls: sift.packages.dconf-cli
      - sls: sift.packages.dbus-x11
    - watch:
      - file: sift-config-terminal-profiles-file

{% else %}

include:
  - sift.packages.dbus-x11
  - sift.config.user.user

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

sift-config-terminal-profiles-jammy:
  cmd.run:
    - name: {{ home }}/.config/terminal.sh
    - runas: {{ user }}
    - shell: /bin/bash
    - cwd: {{ home }}
    - require:
      - file: sift-config-terminal-profiles-jammy-script
      - sls: sift.config.user.user
    - watch:
      - file: sift-config-terminal-profiles-jammy-script

{% endif %}
