sift-microsoft-key:
  file.managed:
    - name: /usr/share/keyrings/MICROSOFT.asc
    - source: https://packages.microsoft.com/keys/microsoft.asc
    - skip_verify: True
    - makedirs: True

microsoft:
  pkgrepo.managed:
    - humanname: Microsoft
    - name: deb [arch=amd64 signed-by=/usr/share/keyrings/MICROSOFT.asc] https://packages.microsoft.com/ubuntu/{{ grains['lsb_distrib_release'] }}/prod {{ grains['lsb_distrib_codename'] }} main
    - dist: {{ grains['lsb_distrib_codename'] }}
    - file: /etc/apt/sources.list.d/microsoft.list
    - refresh: True
    - clean_file: True
    - require:
      - file: sift-microsoft-key
