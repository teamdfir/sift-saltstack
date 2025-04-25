sift-universe-repo:
  pkgrepo.managed:
    - name: deb http://ports.ubuntu.com/ubuntu-ports/ {{ grains['lsb_distrib_codename'] }} universe
    - refresh_db: true
