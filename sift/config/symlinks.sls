include:
  - sift.scripts.regripper

/usr/bin/mactime:
  file.symlink:
    - target: /usr/local/bin/mactime-sleuthkit

/usr/bin/icat:
  file.symlink:
    - target: /usr/bin/icat-sleuthkit 

/usr/bin/log2timeline_legacy:
  file.symlink:
    - target: /usr/bin/log2timeline
    - require:
      - pkg: python-plaso

/usr/bin/l2t_process_old.pl:
  file.symlink:
    - target: /usr/local/bin/l2t_process

/usr/bin/iscsiadm:
  file.symlink:
    - target: /sbin/iscsiadm

/usr/local/bin/rip.pl:
  file.symlink:
    - target: /usr/share/regripper/rip.pl
    - require:
      - file: regripper-files
