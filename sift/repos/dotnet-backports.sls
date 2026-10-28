{% set codename = grains['oscodename'] %}
{% set old_list = salt['file.find']('/etc/apt/sources.list.d', name='*.list', grep='dotnet/backports') %}

sift-dotnet-backports-key:
  file.managed:
    - name: /usr/share/keyrings/dotnet-backports.asc
    - source: https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x45A3F127159BE9E5017811C62125B164E8E5D3FA
    - skip_verify: True
    - makedirs: True
    - mode: '0644'

{% if old_list %}
sift-dotnet-backports-old-list:
  file.absent:
    - names: {{ old_list | json }}
{% endif %}

sift-dotnet-backports-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/dotnet-backports.sources
    - mode: '0644'
    - contents: |
        Types: deb
        URIs: https://ppa.launchpadcontent.net/dotnet/backports/ubuntu
        Suites: {{ codename }}
        Components: main
        Signed-By: /usr/share/keyrings/dotnet-backports.asc
    - unless:
      - grep -qxF 'Types: deb' /etc/apt/sources.list.d/dotnet-backports.sources
      - grep -qxF 'URIs: https://ppa.launchpadcontent.net/dotnet/backports/ubuntu' /etc/apt/sources.list.d/dotnet-backports.sources
      - grep -qxF 'Suites: {{ codename }}' /etc/apt/sources.list.d/dotnet-backports.sources
      - grep -qxF 'Components: main' /etc/apt/sources.list.d/dotnet-backports.sources
      - grep -qxF 'Signed-By: /usr/share/keyrings/dotnet-backports.asc' /etc/apt/sources.list.d/dotnet-backports.sources
      - test "$(stat -c %a /etc/apt/sources.list.d/dotnet-backports.sources)" = "644"
    - require:
      - file: sift-dotnet-backports-key

sift-dotnet-backports-refresh:
  module.run:
    - pkg.refresh_db:
    - onchanges_any:
      - file: sift-dotnet-backports-repo
      - file: sift-dotnet-backports-key
{% if old_list %}
      - file: sift-dotnet-backports-old-list
{% endif %}
