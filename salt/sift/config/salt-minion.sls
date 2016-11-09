salt-minion:
  service.dead:
    - name: salt-minion
    - enable: False

salt-minion-config:
  file.managed:
    - name: /etc/salt/minion
    - source: salt://sift/files/salt-minion/minion
