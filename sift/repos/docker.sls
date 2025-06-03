include:
  - sift.packages.software-properties-common
  - sift.packages.apt-transport-https

sift-docker-key:
  file.managed:
    - name: /usr/share/keyrings/DOCKER-PGP-KEY.asc
    - source: https://download.docker.com/linux/ubuntu/gpg
    - skip_verify: True
    - makedirs: True

sift-docker-repo:
  pkgrepo.managed:
    - humanname: Docker
    - name: deb [signed-by=/usr/share/keyrings/DOCKER-PGP-KEY.asc] https://download.docker.com/linux/ubuntu {{ grains['lsb_distrib_codename'] }} stable
    - dist: {{ grains['lsb_distrib_codename'] }}
    - file: /etc/apt/sources.list.d/docker.list
    - refresh: True
    - require:
      - sls: sift.packages.software-properties-common
      - sls: sift.packages.apt-transport-https
