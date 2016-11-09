universal:
  pkgrepo.managed:
    - humanname: Ubuntu Universal
    - name: deb http://archive.ubuntu.com/ubuntu {{ grains['lsb_distrib_codename'] }} universe main
    - dist: {{ grains['lsb_distrib_codename'] }}
    - file: /etc/apt/sources.list.d/universal.list
    - gpg_check: 0
    - refresh_db: true
