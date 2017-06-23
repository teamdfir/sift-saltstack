{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - .user

theme-set-background:
  file.managed:
    - name: /usr/share/backgrounds/warty-final-ubuntu.png
    - source: salt://sift/files/sift/images/forensics_blue.jpg
    - replace: True
    - require:
      - user: sift-user-{{ user }}

theme-set-unity-logo:
  file.managed:
    - name: /usr/share/unity-greeter/logo.png
    - source: salt://sift/files/sift/images/login_logo.png
    - replace: True
    - require:
      - user: sift-user-{{ user }}

theme-manage-gnome-terminal:
  file.managed:
    - name: /home/{{ user }}/.config/autostart/gnome-terminal.desktop
    - source: salt://sift/files/sift/other/gnome-terminal.desktop
    - replace: True
    - require:
      - user: sift-user-{{ user }}

{%- if grains['oscodename'] == "precise" %}
theme-set-precise-favorites:
  cmd.run:
    - name: "dconf write /desktop/unity/launcher/favorites \"['nautilus.desktop', 'gnome-terminal.desktop', 'firefox.desktop', 'gnome-screenshot.desktop', 'gcalctool.desktop', 'bless.desktop', 'autopsy.desktop', 'wireshark.desktop']\""
    - runas: {{ user }}
    - require:
      - user: sift-user-{{ user }}
{%- endif %}

{%- if grains['oscodename'] == "trusty" %}
theme-set-trusty-favorites:
  cmd.run:
    - name: "gsettings set com.canonical.Unity.Launcher favorites \"['application://nautilus.desktop', 'application://gnome-terminal.desktop', 'application://firefox.desktop', 'application://gnome-screenshot.desktop', 'application://gcalctool.desktop', 'application://bless.desktop', 'application://autopsy.desktop', 'application://wireshark.desktop']\""
    - runas: {{ user }}
    - require:
      - user: sift-user-{{ user }}
{%- endif %}

{%- if grains['oscodename'] == "xenial" %}

{%- endif %}
