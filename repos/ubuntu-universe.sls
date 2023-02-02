sift-universe-repo:
  pkgrepo.managed:
    - name: deb http://archive.ubuntu.com/ubuntu/ {{ grains['lsb_distrib_codename'] }} universe
    - refresh_db: true
