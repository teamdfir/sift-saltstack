{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- set dbus = salt['cmd.run']("ps -u " + user + " e | grep -Eo 'dbus-daemon.*address=unix:abstract=/tmp/dbus-[A-Za-z0-9]{10}' | tail -c35", shell="/bin/bash", runas="root", cwd="/root", python_shell=True) -%}

sift-config-unity-launcher-user:
  cmd.run:
    - name: gsettings set com.canonical.Unity.Launcher launcher-position Bottom
    - runas: {{ user }}
    - cwd: /home/{{ user }}
    - shell: /bin/bash
    - env:
      - DBUS_SESSION_BUS_ADDRESS: "{{ dbus }}"

sift-config-unity-disable-scopes:
  cmd.run:
    - name: gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"
    - runas: {{ user }}
    - cwd: /home/{{ user }}
    - shell: /bin/bash
    - env:
      - DBUS_SESSION_BUS_ADDRESS: "{{ dbus }}"

sift-config-unity-favorites:
  cmd.run:
    - name: gsettings set com.canonical.Unity.Launcher favorites "['application://gnome-terminal.desktop', 'application://firefox.desktop', 'application://org.gnome.Nautilus.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"
    - runas: {{ user }}
    - cwd: /home/{{ user }}
    - shell: /bin/bash
    - env:
      - DBUS_SESSION_BUS_ADDRESS: "{{ dbus }}"

sift-config-unity-icon-size:
  cmd.run:
    - name: dconf write /org/compiz/profiles/unity/plugins/unityshell/icon-size 32
    - runas: {{ user }}
    - cwd: /home/{{ user }}
    - shell: /bin/bash
    - env:
      - DBUS_SESSION_BUS_ADDRESS: "{{ dbus }}"

sift-config-unity-minimize-window:
  cmd.run:
    - name: dconf write /org/compiz/profiles/unity/plugins/unityshell/launcher-minimize-window true
    - runas: {{ user }}
    - cwd: /home/{{ user }}
    - shell: /bin/bash
    - env:
      - DBUS_SESSION_BUS_ADDRESS: "{{ dbus }}"
