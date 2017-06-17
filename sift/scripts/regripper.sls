include:
  - sift.packages.git
  - sift.packages.libparse-win32registry-perl

sift-scripts-regripper-git:
  git.latest:
    - name: https://github.com/keydet89/RegRipper2.8.git
    - target: /usr/local/src/regripper
    - user: root
    - rev: master
    - force_clone: True
    - require:
      - pkg: git

sift-scripts-regripper-directory:
  file.directory:
    - name: /usr/local/share/regripper
    - makedirs: True
    - file_mode: 644
    - require:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-binary:
  file.managed:
    - name: /usr/local/share/regripper/rip.pl
    - source: salt://sift/files/regripper/rip.pl
    - mode: 755
    - require:
      - git: sift-scripts-regripper-git
      - pkg: libparse-win32registry-perl

sift-scripts-regripper-plugins-symlink:
  file.symlink:
    - name: /usr/local/share/regripper/plugins
    - target: /usr/local/src/regripper/plugins
    - require: 
      - git: sift-scripts-regripper-git
      - file: sift-scripts-regripper-directory

sift-scripts-regripper-binary-symlink:
  file.symlink:
    - name: /usr/local/bin/rip.pl
    - target: /usr/local/share/regripper/rip.pl
    - mode: 755
    - require:
      - file: sift-scripts-regripper-binary
