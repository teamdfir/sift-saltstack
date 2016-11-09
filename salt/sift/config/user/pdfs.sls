{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

/home/{{ user }}/Desktop:
  file.recurse:
    - source: salt://sift/files/sift/resources
    - include_pat: '*.pdf'
