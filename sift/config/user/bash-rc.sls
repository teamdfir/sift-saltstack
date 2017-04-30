{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - .user

rc-noclobber:
  file.append:
    - name: /home/{{ user }}/.bashrc
    - text: 'set -o noclobber'
    - require:
      - user: {{ user }}

rekall-path:
  file.append:
    - name: /home/{{ user }}/.bashrc
    - text: 'export PATH=$PATH:/opt/rekall/bin'
    - require:
      - user: {{ user }}

rc-root-noclobber:
  file.append:
    - name: /root/.bashrc
    - text: 'set -o noclobber'
    - require:
      - file: rekall-path
