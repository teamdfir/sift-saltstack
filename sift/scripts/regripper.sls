# source=https://github.com/keydet89/RegRipper2.8
# license=mit
# license_source=https://github.com/keydet89/RegRipper2.8/blob/master/license.md

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
    - force_reset: True
    - require:
      - pkg: git

sift-scripts-regripper-directory:
  file.directory:
    - name: /usr/share/regripper
    - makedirs: True
    - file_mode: 644
    - require:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-binary:
  file.managed:
    - name: /usr/share/regripper/rip.pl
    - source: salt://sift/files/regripper/rip.pl
    - mode: 755
    - require:
      - git: sift-scripts-regripper-git
      - pkg: libparse-win32registry-perl

sift-scripts-regripper-plugins-symlink:
  file.symlink:
    - name: /usr/share/regripper/plugins
    - target: /usr/local/src/regripper/plugins
    - require: 
      - git: sift-scripts-regripper-git
      - file: sift-scripts-regripper-directory

sift-scripts-regripper-binary-symlink:
  file.symlink:
    - name: /usr/local/bin/rip.pl
    - target: /usr/share/regripper/rip.pl
    - mode: 755
    - require:
      - file: sift-scripts-regripper-binary

sift-scripts-regripper-plugins-all:
  cmd.wait:
    - name: "grep -R \"my %config = (hive\" /usr/share/regripper/plugins | grep \"All\" | cut -f1 -d: | xargs -n1 -I{} basename {} | sed 's/.pl$//' > /usr/share/regripper/plugins/all"
    - watch:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-plugins-ntuser:
  cmd.wait:
    - name: "grep -R \"my %config = (hive\" /usr/share/regripper/plugins | grep \"NTUSER\" | cut -f1 -d: | xargs -n1 -I{} basename {} | sed 's/.pl$//' > /usr/share/regripper/plugins/ntuser"
    - watch:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-plugins-usrclass:
  cmd.wait:
    - name: "grep -R \"my %config = (hive\" /usr/share/regripper/plugins | grep \"USRCLASS\" | cut -f1 -d: | xargs -n1 -I{} basename {} | sed 's/.pl$//' > /usr/share/regripper/plugins/usrclass"
    - watch:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-plugins-sam:
  cmd.wait:
    - name: "grep -R \"my %config = (hive\" /usr/share/regripper/plugins | grep \"SAM\" | cut -f1 -d: | xargs -n1 -I{} basename {} | sed 's/.pl$//' > /usr/share/regripper/plugins/sam"
    - watch:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-plugins-security:
  cmd.wait:
    - name: "grep -R \"my %config = (hive\" /usr/share/regripper/plugins | grep \"Security\" | cut -f1 -d: | xargs -n1 -I{} basename {} | sed 's/.pl$//' > /usr/share/regripper/plugins/security"
    - watch:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-plugins-software:
  cmd.wait:
    - name: "grep -R \"my %config = (hive\" /usr/share/regripper/plugins | grep \"Software\" | cut -f1 -d: | xargs -n1 -I{} basename {} | sed 's/.pl$//' > /usr/share/regripper/plugins/software"
    - watch:
      - git: sift-scripts-regripper-git

sift-scripts-regripper-plugins-system:
  cmd.wait:
    - name: "grep -R \"my %config = (hive\" /usr/share/regripper/plugins | grep \"System\" | cut -f1 -d: | xargs -n1 -I{} basename {} | sed 's/.pl$//' > /usr/share/regripper/plugins/system"
    - watch:
      - git: sift-scripts-regripper-git
