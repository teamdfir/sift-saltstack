{% for folder in ['resources','images','audio','other','scripts'] %}
/usr/share/sift/{{folder}}:
  file.directory:
    - user: root
    - group: root
    - makedirs: true
{% endfor %}

sift-resources:
  file.recurse:
    - name: /usr/share/sift
    - source: salt://sift/files/sift
