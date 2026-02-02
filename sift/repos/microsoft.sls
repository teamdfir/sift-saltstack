sift-microsoft-key:
  file.managed:
    - name: /usr/share/keyrings/MICROSOFT.asc
    - source: https://packages.microsoft.com/keys/microsoft.asc
    - skip_verify: True
    - makedirs: True

sift-microsoft-repo-cleanup:
  pkgrepo.absent:
    - name: deb https://packages.microsoft.com/ubuntu/{{ grains['lsb_distrib_release'] }}/prod {{ grains['lsb_distrib_codename'] }} main
    - refresh: true

sift-microsoft-list-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/microsoft.list

sift-microsoft-sources-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/microsoft.sources

sift-microsoft-repo:
  file.managed:
    - name: /etc/apt/sources.list.d/microsoft.sources
    - contents: |
        Types: deb
        URIs: https://packages.microsoft.com/ubuntu/{{ grains['lsb_distrib_release'] }}/prod
        Suites: {{ grains['lsb_distrib_codename'] }}
        Components: main
        Signed-By: /usr/share/keyrings/MICROSOFT.asc
        Architectures: amd64
    - require:
      - file: sift-microsoft-key
      - pkgrepo: sift-microsoft-repo-cleanup
      - file: sift-microsoft-list-absent
      - file: sift-microsoft-sources-absent
