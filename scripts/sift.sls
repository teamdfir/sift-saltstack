{% for folder in ['resources','images','audio','other','scripts'] -%}
scripts-sift-resources-{{ folder }}:
  file.directory:
    - name: /usr/share/sift/{{ folder }}
    - user: root
    - group: root
    - makedirs: true
    - require_in:
      - file: sift-resources
{% endfor -%}

sift-resources:
  file.recurse:
    - name: /usr/share/sift
    - source: salt://sift/files/sift
