{%- set codename = grains['lsb_distrib_codename'] -%}

# Clean up legacy PPA format
sift-dotnet-backports-legacy-ppa-absent:
  pkgrepo.absent:
    - ppa: dotnet/backports
    - require_in:
      - pkgrepo: sift-dotnet-backports-repo

# Clean up DEB822 format (.sources file)
sift-dotnet-backports-deb822-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/dotnet-ubuntu-backports-{{ codename }}.sources
    - require_in:
      - pkgrepo: sift-dotnet-backports-repo

sift-dotnet-backports-key:
  file.managed:
    - name: /usr/share/keyrings/DOTNET-BACKPORTS-GPG-KEY.asc
    - source: https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x45A3F127159BE9E5017811C62125B164E8E5D3FA
    - skip_verify: True
    - makedirs: True

sift-dotnet-backports-repo:
  pkgrepo.managed:
    - humanname: .NET Backports PPA
    - name: deb [signed-by=/usr/share/keyrings/DOTNET-BACKPORTS-GPG-KEY.asc] https://ppa.launchpadcontent.net/dotnet/backports/ubuntu {{ codename }} main
    - dist: {{ codename }}
    - file: /etc/apt/sources.list.d/dotnet-ubuntu-backports-{{ codename }}.list
    - refresh: True
    - clean_file: True
    - require:
      - file: sift-dotnet-backports-key
