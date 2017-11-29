{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - .user

rc-noclobber:
  file.append:
    - name: /home/{{ user }}/.bashrc
    - text: 'set -o noclobber'
    - require:
      - user: sift-user-{{ user }}

rekall-path:
  file.append:
    - name: /home/{{ user }}/.bashrc
    - text: 'export PATH=$PATH:/opt/rekall/bin'
    - require:
      - user: sift-user-{{ user }}

sift-config-user-prompt-command:
  file.append:
    - name: /home/{{ user }}/.bashrc
    - text: siftprompt() { PS1X='$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~";IFS=/; for q in ${p:1}; do printf /${q:0:1}; done; printf "${q:1}")'; export PS1="\[\033[1;31m\]\u@\h\[\033[1;34m\] -> $PS1X \n\[\033[0;37m\]$ \[\033[0m\]"; }
    - require:
      - user: sift-user-{{ user }}

sift-config-user-prompt:
  file.append:
    - name: /home/{{ user }}/.bashrc
    - text: PROMPT_COMMAND="siftprompt"
    - require:
      - user: sift-user-{{ user }}
      - file: sift-config-user-prompt-command

rc-root-noclobber:
  file.append:
    - name: /root/.bashrc
    - text: 'set -o noclobber'
    - require:
      - file: rekall-path

sift-config-root-prompt-command:
  file.append:
    - name: /root/.bashrc
    - text: siftprompt() { PS1X='$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~";IFS=/; for q in ${p:1}; do printf /${q:0:1}; done; printf "${q:1}")'; export PS1="\[\033[1;31m\]\u@\h\[\033[1;34m\] -> $PS1X \n\[\033[0;37m\]# \[\033[0m\]"; }

sift-config-root-prompt:
  file.append:
    - name: /root/.bashrc
    - text: PROMPT_COMMAND="siftprompt"
    - require:
      - file: sift-config-root-prompt-command
