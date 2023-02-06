salt-minion:
  service.dead:
    - name: salt-minion
    - enable: False
