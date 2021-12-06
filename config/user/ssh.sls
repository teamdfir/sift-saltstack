{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}

sift-config-user-ssh-config:
  file.touch:
    - name: {{ home }}/.ssh/config
    - makedirs: True

sift-config-user-ssh-config-gssapi:
  file.replace:
    - name: {{ home }}/.ssh/config
    - pattern: "GSSAPIAuthentication yes"
    - repl: "GSSAPIAuthentication no"
    - ignore_if_missing: True
    - append_if_not_found: True
    - require:
      - file: sift-config-user-ssh-config

sift-config-user-ssh-permissions:
  file.directory:
    - name: {{ home }}/.ssh
    - user: {{ user }}
    - group: {{ user }}
    - dir_mode: 755
    - file_mode: 755
    - recurse:
      - user
      - group
      - mode

  
