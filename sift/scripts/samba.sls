/etc/samba/smb.conf:
  file.managed:
    - source: salt://sift/files/samba/smb.conf
    - replace: False

smbd:
  service.running:
    - reload: True
    - watch:
      - file: /etc/samba/smb.conf

nmbd:
  service.running:
    - reload: True
    - watch:
      - file: /etc/samba/smb.conf
