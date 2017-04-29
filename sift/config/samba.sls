include:
  - ..packages.samba

samba-config:
  file.managed:
    - name: /etc/samba/smb.conf
    - source: salt://sift/files/samba/smb.conf
    - replace: False
    - require:
      - pkg: samba

samba-service-smbd:
  service.running:
    - name: smbd
    - reload: True
    - watch:
      - file: /etc/samba/smb.conf

samba-service-nmbd:
  service.running:
    - name: nmbd
    - reload: True
    - watch:
      - file: /etc/samba/smb.conf
