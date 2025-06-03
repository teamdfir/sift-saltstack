sift-multiverse-repo:
  pkgrepo.managed:
    - name: deb http://ports.ubuntu.com/ubuntu-ports/ {{ grains['lsb_distrib_codename'] }} multiverse
    - refresh_db: true

sift-multiverse-repo-security:
  pkgrepo.managed:
    - name: deb http://ports.ubuntu.com/ubuntu-ports/ {{ grains['lsb_distrib_codename'] }}-security multiverse
    - refresh_db: true

