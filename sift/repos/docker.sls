sift-docker-key:
  file.managed:
    - name: /usr/share/keyrings/DOCKER-PGP-KEY.asc
    - source: https://download.docker.com/linux/ubuntu/gpg
    - skip_verify: True
    - makedirs: True

sift-remove-docker-ppa:
  pkgrepo.absent:
    - ppa: docker/stable

sift-remove-docker-list:
  file.absent:
    - name: /etc/apt/sources.list.d/docker.list
    - require:
      - pkgrepo: sift-remove-docker-ppa

sift-remove-docker-sources:
  file.absent:
    - name: /etc/apt/sources.list.d/docker.sources
    - require:
      - pkgrepo: sift-remove-docker-ppa

sift-docker-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/docker.sources
    - contents: |
        Types: deb
        URIs: https://download.docker.com/linux/ubuntu
        Suites: {{ grains['lsb_distrib_codename'] }}
        Components: stable
        Signed-By: /usr/share/keyrings/DOCKER-PGP-KEY.asc
        Architectures: amd64
    - require:
      - file: sift-docker-key
      - pkgrepo: sift-remove-docker-ppa
      - file: sift-remove-docker-list
      - file: sift-remove-docker-sources
