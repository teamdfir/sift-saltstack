sift-adoptium-key:
  file.managed:
    - name: /usr/share/keyrings/ADOPTIUM.asc
    - source: https://packages.adoptium.net/artifactory/api/gpg/key/public
    - skip_verify: True
    - makedirs: True

sift-adoptium-openjdk-repo-cleanup:
  pkgrepo.absent:
    - name: openjdk-r/ppa
    - refresh: True

sift-adoptium-openjdk-list-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/openjdk-r-ubuntu-ppa-{{ grains['lsb_distrib_codename'] }}.sources
    - require:
      - pkgrepo: sift-adoptium-openjdk-repo-cleanup

sift-adoptium-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/adoptium.sources
    - contents: |
        Types: deb
        URIs: https://packages.adoptium.net/artifactory/deb
        Suites: {{ grains['lsb_distrib_codename'] }}
        Components: main
        Signed-By: /usr/share/keyrings/ADOPTIUM.asc
        Architectures: amd64
    - require:
      - file: sift-adoptium-key
      - pkgrepo: sift-adoptium-openjdk-repo-cleanup
      - file: sift-adoptium-openjdk-list-absent

