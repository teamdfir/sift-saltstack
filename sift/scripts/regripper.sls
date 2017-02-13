include:
  - sift.packages.dos2unix

regripper-directory:
  file.directory:
    - name: /usr/share/regripper
    - makedirs: True
    - file_mode: 644

regripper-files:
  file.recurse:
    - name: /usr/share/regripper
    - source: salt://sift/files/regripper
    - file_mode: 755
    - require:
      - file: regripper-directory

regripper-dos2unix:
  cmd.run:
    - name: dos2unix -ascii /usr/share/regripper/*
    - require:
      - file: regripper-files
      - pkg: dos2unix

/usr/share/regripper/plugins/usrclass:
  file.rename:
    - source: /usr/share/regripper/plugins/usrclass-all
    - force: True
    - require:
      - cmd: regripper-dos2unix

/usr/share/regripper/plugins/ntuser:
  file.rename:
    - source: /usr/share/regripper/plugins/ntuser-all
    - force: True
    - require:
      - cmd: regripper-dos2unix 
