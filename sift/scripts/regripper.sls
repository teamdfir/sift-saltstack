include:
  - ..packages.dos2unix

scripts-regripper-directory:
  file.directory:
    - name: /usr/share/regripper
    - makedirs: True
    - file_mode: 644

scripts-regripper-files:
  file.recurse:
    - name: /usr/share/regripper
    - source: salt://sift/files/regripper
    - file_mode: 755
    - require:
      - file: scripts-regripper-directory

scripts-regripper-binary:
  file.managed:
    - name: /usr/share/regripper/rip.pl
    - source: salt://sift/files/regripper/rip.pl
    - mode: 755
    - require:
      - file: scripts-regripper-files

scripts-regripper-symlink:
  file.symlink:
    - name: /usr/local/bin/rip.pl
    - target: /usr/share/regripper/rip.pl
    - mode: 755
    - require:
      - file: scripts-regripper-binary

scripts-regripper-dos2unix:
  cmd.run:
    - name: dos2unix -ascii /usr/share/regripper/*
    - require:
      - file: scripts-regripper-files
      - pkg: dos2unix

scripts-regripper-usrclass-rename:
  file.rename:
    - name: /usr/share/regripper/plugins/usrclass
    - source: /usr/share/regripper/plugins/usrclass-all
    - force: True
    - require:
      - cmd: scripts-regripper-dos2unix

scripts-regripper-ntuser-rename:
  file.rename:
    - name: /usr/share/regripper/plugins/ntuser
    - source: /usr/share/regripper/plugins/ntuser-all
    - force: True
    - require:
      - cmd: scripts-regripper-dos2unix 
