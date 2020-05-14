{%- set base_url = "https://github.com/sleuthkit/sleuthkit/releases/download/sleuthkit-" -%}
{%- set version = "4.9.0" -%}
{%- set filename = "sleuthkit-4.9.0.tar.gz" -%}
{%- set hash = "7bc5ee9130b1ed8d645e446e0f63bd34ad018a93c1275688fa38cfda28bde9d0" -%}

include:
  - sift.repos.gift
  - sift.packages.libewf-dev
  - sift.packages.libvmdk-dev
  - sift.packages.libafflib-dev
  - sift.packages.zlib1g-dev
  - sift.packages.libvhdi-dev
  - sift.packages.build-essential

sift-packages-sleuthkit-source:
  file.managed:
    - name: "/var/cache/sift/archives/{{ filename }}"
    - source: "{{ base_url }}{{ version }}/{{ filename }}"
    - source_hash: sha256={{ hash }}
    - makedirs: true

sift-packages-sleuthkit-archive:
  archive.extracted:
    - name: /var/cache/sift/archives/
    - source: "/var/cache/sift/archives/{{ filename }}"
    - enforce_toplevel: true
    - watch:
      - file: sift-packages-sleuthkit-source

sift-packages-sleuthkit-configure:
  cmd.run:
    - name: ./configure && make install
    - cwd: /var/cache/sift/archives/sleuthkit-4.9.0
    - watch:
      - archive: sift-packages-sleuthkit-archive

sift-packages-sleuthkit-rm-dir:
  file.absent:
    - name: /var/cache/sift/archives/sleuthkit-4.9.0
    - watch:
      - cmd: sift-packages-sleuthkit-configure
