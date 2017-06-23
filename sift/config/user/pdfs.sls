{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - .user

pdfs-resource-copy:
  file.recurse:
    - name: /home/{{ user }}/Desktop
    - source: salt://sift/files/sift/resources
    - include_pat: '*.pdf'
    - require:
      - user: sift-user-{{ user }}
