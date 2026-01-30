{%- set codename = grains['lsb_distrib_codename'] -%}

# Clean up legacy PPA format
sift-openjdk-legacy-ppa-absent:
  pkgrepo.absent:
    - ppa: openjdk-r/ppa
    - require_in:
      - pkgrepo: openjdk-repo

# Clean up DEB822 format (.sources file)
sift-openjdk-deb822-absent:
  file.absent:
    - name: /etc/apt/sources.list.d/openjdk-r-ubuntu-ppa-{{ codename }}.sources
    - require_in:
      - pkgrepo: openjdk-repo

sift-openjdk-key:
  file.managed:
    - name: /usr/share/keyrings/OPENJDK-PGP-KEY.asc
    - source: https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xDA1A4A13543B466853BAF164EB9B1D8886F44E2A
    - skip_verify: True
    - makedirs: True

openjdk-repo:
  pkgrepo.managed:
    - humanname: OpenJDK PPA
    - name: deb [signed-by=/usr/share/keyrings/OPENJDK-PGP-KEY.asc] https://ppa.launchpadcontent.net/openjdk-r/ppa/ubuntu {{ codename }} main
    - dist: {{ codename }}
    - file: /etc/apt/sources.list.d/openjdk-r-ubuntu-ppa-{{ codename }}.list
    - refresh: True
    - clean_file: True
    - require:
      - file: sift-openjdk-key
