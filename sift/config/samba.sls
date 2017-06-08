include:
  - ..packages.samba

sift-samba-initial:
  file.managed:
    - name: /etc/samba/.sift-samba
    - contents: |
        This file indicates to SIFT that it has made the changes to the smb.conf file
        and prevents it from overwritting it should a user make custom changes.

samba-config:
  file.managed:
    - name: /etc/samba/smb.conf
    - source: salt://sift/files/samba/smb.conf
    - require:
      - pkg: samba
    - watch:
      - file: sift-samba-initial

samba-service-smbd:
  service.running:
    - name: smbd
    - watch:
      - file: /etc/samba/smb.conf

samba-service-nmbd:
  service.running:
    - name: nmbd
    - require:
      - service: samba-service-smbd
    - watch:
      - file: /etc/samba/smb.conf
