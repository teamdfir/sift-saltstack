{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

rc-noclobber:
  file.append:
    - name: /home/{{ user }}/.bashrc
    - text: 'set -o noclobber'

rekall-path:
  file.append:
    - name: /home/{{ user }}/.bashrc
    - text: 'export PATH=$PATH:/opt/rekall/bin'

rc-root-noclobber:
  file.append:
    - name: /root/.bashrc
    - text: 'set -o noclobber'
