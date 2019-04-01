include:
  - sift.packages.software-properties-common
  - sift.packages.apt-transport-https

sift-docker-repo:
  pkgrepo.managed:
    - humanname: Docker
    - name: deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ grains['lsb_distrib_codename'] }} stable
    - dist: {{ grains['lsb_distrib_codename'] }}
    - file: /etc/apt/sources.list.d/docker.list
    # - keyid: 9DC858229FC7DD38854AE2D88D81803C0EBFCD88
    # - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - key_url: https://download.docker.com/linux/ubuntu/gpg
    - refresh: true
    - require:
      - sls: sift.packages.software-properties-common
      - sls: sift.packages.apt-transport-https
