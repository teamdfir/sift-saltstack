{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- if user == "root" -%}
  {%- set home = "/root" -%}
{%- else -%}
  {%- set home = salt['user.info'](user).home -%}
{%- endif -%}

include:
  - sift.config.user.user

rc-noclobber:
  file.append:
    - name: {{ home }}/.bashrc
    - text: 'set -o noclobber'
    - require:
      - user: sift-user-{{ user }}

rekall-path:
  file.append:
    - name: {{ home }}/.bashrc
    - text: 'export PATH=$PATH:/opt/rekall/bin'
    - require:
      - user: sift-user-{{ user }}

sift-config-user-prompt-command-remove-old1:
  file.line:
    - name: {{ home }}/.bashrc
    - match: siftprompt
    - mode: delete
    - require:
      - user: sift-user-{{ user }}

sift-config-user-prompt-command-remove-old2:
  file.line:
    - name: {{ home }}/.bashrc
    - match: PROMPT_COMMAND
    - mode: delete
    - require:
      - user: sift-user-{{ user }}

sift-config-user-prompt-command:
  file.append:
    - name: {{ home }}/.bashrc
    - text: |
        if [ $EUID -eq 0 ]; then PS1="\[\033[1;91m\]\u@\h\[\033[0m\]: \[\033[32m\]\w\[\033[0m\]\n\\$ "; else PS1="\[\033[1;36m\]\u@\h\[\033[0m\]: \[\033[32m\]\w\[\033[0m\]\n\\$ "; fi
    - require:
      - user: sift-user-{{ user }}

rc-root-noclobber:
  file.append:
    - name: /root/.bashrc
    - text: 'set -o noclobber'
    - require:
      - file: rekall-path

sift-config-root-prompt-remove:
  file.line:
    - name: /root/.bashrc
    - match: siftprompt
    - mode: delete

sift-config-root-prompt:
  file.line:
    - name: /root/.bashrc
    - match: PROMPT_COMMAND
    - mode: delete
    - require:
      - file: sift-config-root-prompt-remove
