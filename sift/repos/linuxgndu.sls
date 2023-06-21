sift-linuxgndu-key:
  file.managed:
    - name: /usr/share/keyrings/LINUXGNDU-GPG.asc
    - source: https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xb0c3f48a7f2583ea
    - skip_verify: True
    - makedirs: True

linuxgndu:
  pkgrepo.managed:
    - humanname: linuxgndu
    - name: deb [arch=amd64 signed-by=/usr/share/keyrings/LINUXGNDU-GPG.asc] https://ppa.launchpadcontent.net/linuxgndu/sqlitebrowser/ubuntu {{ grains['lsb_distrib_codename'] }} main
    - dist: {{ grains['lsb_distrib_codename'] }}
    - file: /etc/apt/sources.list.d/linuxgndu.list
    - refresh: True
    - clean_file: True
    - require:
      - file: sift-linuxgndu-key
