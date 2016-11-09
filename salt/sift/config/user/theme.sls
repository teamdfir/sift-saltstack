{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

/usr/share/backgrounds/warty-final-ubuntu.png:
  file.managed:
    - source: salt://sift/files/sift/images/forensics_blue.jpg
    - replace: True

/usr/share/unity-greeter/logo.png:
  file.managed:
    - source: salt://sift/files/sift/images/login_logo.png
    - replace: True

/home/{{ user }}/.config/autostart/gnome-terminal.desktop:
  file.managed:
    - source: salt://sift/files/sift/other/gnome-terminal.desktop
    - replace: True

{%- if grains['oscodename'] == "precise" %}
set-precise-favorites:
  cmd.run:
    - name: "dconf write /desktop/unity/launcher/favorites \"['nautilus.desktop', 'gnome-terminal.desktop', 'firefox.desktop', 'gnome-screenshot.desktop', 'gcalctool.desktop', 'bless.desktop', 'autopsy.desktop', 'wireshark.desktop']\""
    - runas: {{ user }}
{%- endif %}

{%- if grains['oscodename'] == "trusty" %}
set-trusty-favorites:
  cmd.run:
    - name: "gsettings set com.canonical.Unity.Launcher favorites \"['application://nautilus.desktop', 'application://gnome-terminal.desktop', 'application://firefox.desktop', 'application://gnome-screenshot.desktop', 'application://gcalctool.desktop', 'application://bless.desktop', 'application://autopsy.desktop', 'application://wireshark.desktop']\""
    - runas: {{ user }}
{%- endif %}

{%- if grains['oscodename'] == "xenial" %}

{%- endif %}

remove-broken-links:
  cmd.run:
    - name: find -L /home/{{ user }}/Desktop -type l -delete
    - runas: {{ user }}
